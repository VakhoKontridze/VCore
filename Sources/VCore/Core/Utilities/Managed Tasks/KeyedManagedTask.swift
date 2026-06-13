//
//  KeyedManagedTask.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/3/26.
//

import Foundation
import os

/// `Task` wrapper that deduplicates concurrent calls per key, ensuring only one operation per key runs at a time.
nonisolated public final class KeyedManagedTask<Key, Success>: Sendable
    where
        Key: Hashable & Sendable,
        Success: Sendable
{
    // MARK: Properties
    private let lock: OSAllocatedUnfairLock<State> = .init(initialState: State())
    
    // MARK: Initializers
    /// Initializes `KeyedManagedTask`.
    public init() {}
    
    // MARK: API
    /// Runs the operation for the given key, or joins an existing in-flight operation for that key if one exists.
    /// If the caller is cancelled, it detaches without affecting other waiters.
    public func run(
        key: Key,
        @_implicitSelfCapture operation: @Sendable @escaping () async throws -> Success
    ) async throws -> Success {
        let (sessionID, task): (Int, TaskType) = lock.withLock { state in
            var entry: Entry = state.entries[key] ?? Entry()

            if let existingTask: TaskType = entry.task {
                entry.waiterCount += 1
                state.entries[key] = entry
                
                return (entry.sessionID, existingTask)

            } else {
                state.sessionID += 1
                let sessionID: Int = state.sessionID

                entry.sessionID = sessionID
                
                entry.waiterCount = 1

                let task: TaskType = .init {
                    defer {
                        lock.withLock { state in
                            if state.entries[key]?.sessionID == sessionID {
                                state.entries[key] = nil
                            }
                        }
                    }

                    return try await operation()
                }
                entry.task = task
                state.entries[key] = entry

                return (sessionID, task)
            }
        }

        // `max` guards against potential double-decrement if both
        // `operation`'s defer and `onCancel` fire for the same waiter.
        return try await withTaskCancellationHandler(
            operation: {
                defer {
                    lock.withLock { state in
                        if state.entries[key]?.sessionID == sessionID {
                            let count: Int = state.entries[key]?.waiterCount ?? 0
                            state.entries[key]?.waiterCount = max(0, count - 1)
                        }
                    }
                }

                return try await task.value
            },
            onCancel: {
                let taskToCancel: TaskType? = lock.withLock { state in
                    guard sessionID == state.entries[key]?.sessionID else { return nil }

                    let count: Int = state.entries[key]?.waiterCount ?? 0
                    state.entries[key]?.waiterCount = max(0, count - 1)
                    guard (state.entries[key]?.waiterCount ?? 0) == 0 else { return nil }

                    let task: TaskType? = state.entries[key]?.task
                    state.entries[key] = nil

                    return task
                }

                taskToCancel?.cancel()
            }
        )
    }
    
    /// Resets operation for the given key.
    ///
    /// If `cancelForAllWaiters` is `true`, operation will be cancelled regardless of how many callers are waiting.
    /// If `cancelForAllWaiters` is `false`, operation will only be cancelled if no other callers are currently waiting.
    public func reset(
        key: Key,
        cancelForAllWaiters: Bool
    ) {
        let taskToCancel: TaskType? = lock.withLock { state in
            if !cancelForAllWaiters {
                guard (state.entries[key]?.waiterCount ?? 0) <= 1 else { return nil }
            }

            let task: TaskType? = state.entries[key]?.task
            state.entries[key] = nil

            return task
        }

        taskToCancel?.cancel()
    }

    /// Resets all operations across all keys.
    ///
    /// If `cancelForAllWaiters` is `true`, all operations will be cancelled regardless of how many callers are waiting.
    /// If `cancelForAllWaiters` is `false`, only operations with no other callers currently waiting will be cancelled.
    public func resetAll(
        cancelForAllWaiters: Bool
    ) {
        let tasksToCancel: [TaskType] = lock.withLock { state in
            var tasksToCancel: [TaskType] = []

            for key in Array(state.entries.keys) { // `Array` captures snapshot
                if !cancelForAllWaiters {
                    guard (state.entries[key]?.waiterCount ?? 0) <= 1 else { continue }
                }

                if let task: TaskType = state.entries[key]?.task {
                    tasksToCancel.append(task)
                }
                state.entries[key] = nil
            }

            return tasksToCancel
        }

        for task in tasksToCancel {
            task.cancel()
        }
    }
    
    // MARK: Types
    private typealias TaskType = Task<Success, any Error>

    nonisolated private struct Entry {
        var sessionID: Int = 0
        var task: Task<Success, any Error>?
        var waiterCount: Int = 0
    }

    nonisolated private struct State {
        var sessionID: Int = 0
        var entries: [Key: Entry] = [:]
    }
}
