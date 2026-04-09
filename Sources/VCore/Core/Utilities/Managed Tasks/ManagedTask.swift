//
//  ManagedTask.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/3/26.
//

import Foundation
import os

/// `Task` wrapper that deduplicates concurrent calls, ensuring only one operation runs at a time.
nonisolated public final class ManagedTask<Success>: @unchecked Sendable
    where Success: Sendable
{
    // MARK: Properties
    private let lock: OSAllocatedUnfairLock<State> = .init(initialState: State())
    
    // MARK: Initializers
    /// Initializes `ManagedTask`.
    public init() {}
    
    // MARK: Run
    /// Runs the operation, or joins an existing in-flight operation if one exists.
    /// If the caller is cancelled, it detaches without affecting other waiters.
    public func run(
        operation: @Sendable @escaping () async throws -> Success
    ) async throws -> Success {
        let task: TaskType = lock.withLock { state in
            state.waiterCount += 1
            
            if let existingTask: TaskType = state.task {
                return existingTask
                
            } else {
                let task: TaskType = .init {
                    defer {
                        lock.withLock { state in
                            state.task = nil
                        }
                    }
                    
                    return try await operation()
                }
                state.task = task
                
                return task
            }
        }

        // `max` guards against potential double-decrement if both
        // `operation`'s defer and `onCancel` fire for the same waiter.
        return try await withTaskCancellationHandler(
            operation: {
                defer {
                    lock.withLock { state in
                        state.waiterCount = max(0, state.waiterCount - 1)
                    }
                }

                return try await task.value
            },
            onCancel: {
                let shouldCancel: Bool = lock.withLock { state in
                    state.waiterCount = max(0, state.waiterCount - 1)
                    
                    return state.waiterCount == 0
                }
                
                if shouldCancel {
                    task.cancel()
                }
            }
        )
    }
    
    // MARK: Cancel
    /// Cancels the in-flight operation.
    ///
    /// If `forAllWaiters` is `true`, operation will be cancelled regardless of how many callers are waiting.
    /// If `forAllWaiters` is `false`, operation will only be cancelled if no other callers are currently waiting.
    public func cancel(
        forAllWaiters: Bool
    ) {
        lock.withLock { state in
            if !forAllWaiters {
                guard state.waiterCount <= 1 else { return }
            }
            
            state.task?.cancel()
            state.task = nil
            
            state.waiterCount = 0
        }
    }
    
    // MARK: Types
    private typealias TaskType = Task<Success, any Error>
    
    private struct State {
        var task: TaskType?
        var waiterCount: Int = 0
    }
}
