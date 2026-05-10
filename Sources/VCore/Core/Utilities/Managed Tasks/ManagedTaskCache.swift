//
//  ManagedTaskCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/5/26.
//

import Foundation
import os

/// `Task` wrapper that caches and deduplicates concurrent calls, ensuring only one operation runs at a time.
nonisolated public final class ManagedTaskCache<Success>: Sendable
    where Success: Sendable
{
    // MARK: Properties
    private let task: ManagedTask<Success> = .init()
    
    private let lock: OSAllocatedUnfairLock<Success?> = .init(initialState: nil)

    // MARK: Initializers
    /// Initializes `ManagedTaskCache`.
    public init() {}

    // MARK: API
    /// Reads from cache, runs the operation, or joins an existing in-flight operation if one exists.
    /// If the caller is cancelled, it detaches without affecting other waiters.
    public func run(
        @_implicitSelfCapture operation: @Sendable @escaping () async throws -> Success
    ) async throws -> Success {
        if let success: Success = lock.withLock({ $0 }) {
            return success
        }

        let success: Success = try await task.run(operation: operation)
        try Task.checkCancellation()

        lock.withLock { state in
            // Writes only if empty, as another wait may have already arrived here
            if state == nil {
                state = success
            }
        }

        return success
    }

    /// Cancels the in-flight operation.
    ///
    /// If `forAllWaiters` is `true`, operation will be cancelled regardless of how many callers are waiting.
    /// If `forAllWaiters` is `false`, operation will only be cancelled if no other callers are currently waiting.
    public func cancel(
        forAllWaiters: Bool,
        clearCache: Bool
    ) {
        task.cancel(
            forAllWaiters: forAllWaiters
        )
        
        if clearCache {
            lock.withLock { state in
                state = nil
            }
        }
    }
}
