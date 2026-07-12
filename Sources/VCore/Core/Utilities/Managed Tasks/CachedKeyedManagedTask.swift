//
//  CachedKeyedManagedTask.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/5/26.
//

import Foundation
import os

/// `Task` wrapper that caches and deduplicates concurrent calls per key, ensuring only one operation per key runs at a time.
nonisolated public final class CachedKeyedManagedTask<Key, Success>: Sendable
    where
        Key: Hashable & Sendable,
        Success: Sendable
{
    // MARK: Properties
    private let task: KeyedManagedTask<Key, Success> = .init()
    
    private let lock: OSAllocatedUnfairLock<State> = .init(initialState: State())

    // MARK: Initializers
    /// Initializes `CachedKeyedManagedTask`.
    public init() {}

    // MARK: API
    /// Value.
    public var value: [Key: Success]? {
        lock.withLock { $0.entries }
    }
    
    /// Reads from cache, runs the operation for the given key, or joins an existing in-flight operation for that key if one exists.
    /// If the caller is cancelled, it detaches without affecting other waiters.
    public func run(
        key: Key,
        @_implicitSelfCapture operation: @Sendable @escaping () async throws -> Success
    ) async throws -> Success {
        if let success: Success = lock.withLock({ $0.entries[key] }) {
            return success
        }

        let success: Success = try await task.run(
            key: key,
            operation: operation
        )
        try Task.checkCancellation()

        lock.withLock { state in
            // Writes only if empty, as another wait may have already arrived here
            if state.entries[key] == nil {
                state.entries[key] = success
            }
        }

        return success
    }

    /// Resets operation for the given key.
    ///
    /// If `cancelForAllWaiters` is `true`, operation will be cancelled regardless of how many callers are waiting.
    /// If `cancelForAllWaiters` is `false`, operation will only be cancelled if no other callers are currently waiting.
    public func reset(
        key: Key,
        cancelForAllWaiters: Bool,
        clearCache: Bool
    ) {
        task.reset(
            key: key,
            cancelForAllWaiters: cancelForAllWaiters
        )
        
        if clearCache {
            lock.withLock { state in
                state.entries[key] = nil
            }
        }
    }
    
    /// Resets all operations across all keys.
    ///
    /// If `cancelForAllWaiters` is `true`, all operations will be cancelled regardless of how many callers are waiting.
    /// If `cancelForAllWaiters` is `false`, only operations with no other callers currently waiting will be cancelled.
    public func resetAll(
        cancelForAllWaiters: Bool,
        clearCache: Bool
    ) {
        task.resetAll(
            cancelForAllWaiters: cancelForAllWaiters
        )
        
        if clearCache {
            lock.withLock { state in
                state.entries.removeAll()
            }
        }
    }
    
    // MARK: Types
    nonisolated private struct State {
        var entries: [Key: Success] = [:]
    }
}
