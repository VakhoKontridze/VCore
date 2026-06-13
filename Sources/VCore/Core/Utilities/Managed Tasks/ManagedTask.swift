//
//  ManagedTask.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/3/26.
//

import Foundation
import os

/// `Task` wrapper that deduplicates concurrent calls, ensuring only one operation runs at a time.
nonisolated public final class ManagedTask<Success>: Sendable
    where Success: Sendable
{
    // MARK: Properties
    private let lock: OSAllocatedUnfairLock<State> = .init(initialState: State())
    
    // MARK: Initializers
    /// Initializes `ManagedTask`.
    public init() {}
    
    // MARK: API
    /// Runs the operation, or joins an existing in-flight operation if one exists.
    /// If the caller is cancelled, it detaches without affecting other waiters.
    public func run(
        @_implicitSelfCapture operation: @Sendable @escaping () async throws -> Success
    ) async throws -> Success {
        let (sessionID, task): (Int, TaskType) = lock.withLock { state in
            if let existingTask: TaskType = state.task {
                state.waiterCount += 1
                
                return (state.sessionID, existingTask)

            } else {
                state.sessionID += 1
                let sessionID: Int = state.sessionID
                
                state.waiterCount = 1

                let task: TaskType = .init {
                    defer {
                        lock.withLock { state in
                            if sessionID == state.sessionID {
                                state.task = nil
                            }
                        }
                    }

                    return try await operation()
                }
                state.task = task
                
                return (sessionID, task)
            }
        }

        // `max` guards against potential double-decrement if both
        // `operation`'s defer and `onCancel` fire for the same waiter.
        return try await withTaskCancellationHandler(
            operation: {
                defer {
                    lock.withLock { state in
                        if sessionID == state.sessionID {
                            state.waiterCount = max(0, state.waiterCount - 1)
                        }
                    }
                }

                return try await task.value
            },
            onCancel: {
                let taskToCancel: TaskType? = lock.withLock { state in
                    guard sessionID == state.sessionID else { return nil }
                    
                    state.waiterCount = max(0, state.waiterCount - 1)
                    guard state.waiterCount == 0 else { return nil }

                    let task: TaskType? = state.task
                    state.sessionID += 1
                    state.task = nil
                    
                    return task
                }

                taskToCancel?.cancel()
            }
        )
    }
    
    /// Resets operation.
    ///
    /// If `cancelForAllWaiters` is `true`, operation will be cancelled regardless of how many callers are waiting.
    /// If `cancelForAllWaiters` is `false`, operation will only be cancelled if no other callers are currently waiting.
    public func reset(
        cancelForAllWaiters: Bool
    ) {
        let taskToCancel: TaskType? = lock.withLock { state in
            if !cancelForAllWaiters {
                guard state.waiterCount <= 1 else { return nil }
            }
            
            let task: TaskType? = state.task
            state.sessionID += 1
            state.task = nil
            state.waiterCount = 0
            
            return task
        }
        
        taskToCancel?.cancel()
    }
    
    // MARK: Types
    private typealias TaskType = Task<Success, any Error>
    
    nonisolated private struct State {
        var sessionID: Int = 0
        var task: TaskType?
        var waiterCount: Int = 0
    }
}
