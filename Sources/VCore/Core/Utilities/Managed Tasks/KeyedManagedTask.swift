//
//  KeyedManagedTask.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/3/26.
//

import Foundation
import os

/// `Task` wrapper that deduplicates concurrent calls per key, ensuring only one operation per key runs at a time.
nonisolated public final class KeyedManagedTask<Key, Success>: @unchecked Sendable
    where
        Key: Hashable & Sendable,
        Success: Sendable
{
    // MARK: Properties
    private let lock: OSAllocatedUnfairLock<State> = .init(initialState: State())
    
    // MARK: Initializers
    /// Initializes `KeyedManagedTask`.
    public init() {}
    
    // MARK: Run
    /// Runs the operation for the given key, or joins an existing in-flight operation for that key if one exists.
    /// If the caller is cancelled, it detaches without affecting other waiters.
    public func run(
        key: Key,
        operation: @Sendable @escaping () async throws -> Success
    ) async throws -> Success {
        let task: TaskType = lock.withLock { state in
            var entry: Entry = state.entries[key] ?? Entry()
            entry.waiterCount += 1

            if let existingTask: TaskType = entry.task {
                state.entries[key] = entry
                return existingTask

            } else {
                let task: TaskType = .init {
                    defer {
                        lock.withLock { state in
                            state.entries[key]?.task = nil
                        }
                    }

                    return try await operation()
                }
                entry.task = task
                state.entries[key] = entry

                return task
            }
        }

        // `max` guards against potential double-decrement if both
        // `operation`'s defer and `onCancel` fire for the same waiter.
        return try await withTaskCancellationHandler(
            operation: {
                defer {
                    lock.withLock { state in
                        let count: Int = state.entries[key]?.waiterCount ?? 0
                        state.entries[key]?.waiterCount = max(0, count - 1)
                    }
                }

                return try await task.value
            },
            onCancel: {
                let shouldCancel: Bool = lock.withLock { state in
                    let count: Int = state.entries[key]?.waiterCount ?? 0
                    state.entries[key]?.waiterCount = max(0, count - 1)
                    
                    return (state.entries[key]?.waiterCount ?? 0) == 0
                }

                if shouldCancel {
                    task.cancel()
                }
            }
        )
    }
    
    // MARK: Cancel
    /// Cancels the in-flight operation for the given key.
    ///
    /// If `forAllWaiters` is `true`, operation will be cancelled regardless of how many callers are waiting.
    /// If `forAllWaiters` is `false`, operation will only be cancelled if no other callers are currently waiting.
    public func cancel(
        key: Key,
        forAllWaiters: Bool
    ) {
        lock.withLock { state in
            if !forAllWaiters {
                guard (state.entries[key]?.waiterCount ?? 0) <= 1 else { return }
            }

            state.entries[key]?.task?.cancel()
            state.entries[key] = nil
        }
    }

    /// Cancels all in-flight operations across all keys.
    ///
    /// If `forAllWaiters` is `true`, all operations will be cancelled regardless of how many callers are waiting.
    /// If `forAllWaiters` is `false`, only operations with no other callers currently waiting will be cancelled.
    public func cancelAll(
        forAllWaiters: Bool
    ) {
        lock.withLock { state in
            for key in Array(state.entries.keys) { // `Array` captures snapshot
                if !forAllWaiters {
                    guard (state.entries[key]?.waiterCount ?? 0) <= 1 else { continue }
                }

                state.entries[key]?.task?.cancel()
                state.entries[key] = nil
            }
        }
    }
    
    // MARK: Types
    private typealias TaskType = Task<Success, any Error>

    private struct Entry {
        var task: Task<Success, any Error>?
        var waiterCount: Int = 0
    }

    private struct State {
        var entries: [Key: Entry] = [:]
    }
}
