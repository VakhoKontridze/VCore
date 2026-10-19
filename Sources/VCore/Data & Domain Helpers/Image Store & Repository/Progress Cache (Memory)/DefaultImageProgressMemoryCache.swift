//
//  DefaultImageProgressMemoryCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if canImport(UIKit)
public import UIKit
#elseif canImport(AppKit)
public import AppKit
#endif

/// Default image progress memory cache.
nonisolated open class DefaultImageProgressMemoryCache: ImageProgressMemoryCache, @unchecked Sendable {
    // MARK: Properties - Tasks
    private let originalTask: KeyedManagedTask<ImageProgressMemoryCacheOriginalKey, PlatformImage> = .init()
    private let resizedTask: KeyedManagedTask<ImageProgressMemoryCacheResizedKey, PlatformImage> = .init()

    // MARK: Initializers
    /// Initializes `DefaultImageProgressMemoryCache`.
    public init() {}

    // MARK: Operation - Run
    /// Runs operation for original image, or joins an in-flight one with the same key.
    open func run(
        key: ImageProgressMemoryCacheOriginalKey,
        operation: @Sendable @escaping () async throws -> PlatformImage
    ) async throws -> PlatformImage {
        try await originalTask.run(
            key: key,
            operation: operation
        )
    }

    /// Runs operation for resized image, or joins an in-flight one with the same key.
    open func run(
        key: ImageProgressMemoryCacheResizedKey,
        operation: @Sendable @escaping () async throws -> PlatformImage
    ) async throws -> PlatformImage {
        try await resizedTask.run(
            key: key,
            operation: operation
        )
    }

    // MARK: Operation - Cancel
    /// Cancels in-flight original image for all waiters.
    open func cancel(
        key: ImageProgressMemoryCacheOriginalKey
    ) {
        originalTask.reset(
            key: key,
            cancelForAllWaiters: true
        )
    }

    /// Cancels in-flight resized image for all waiters.
    open func cancel(
        key: ImageProgressMemoryCacheResizedKey,
        cancelAllSizes: Bool
    ) {
        if cancelAllSizes {
            for key in resizedTask.keys.filter({ $0.parameter == key.parameter }) {
                resizedTask.reset(
                    key: key,
                    cancelForAllWaiters: true
                )
            }

        } else {
            resizedTask.reset(
                key: key,
                cancelForAllWaiters: true
            )
        }
    }

    // MARK: Operation - Cancel All
    /// Cancels all in-flight images for all waiters.
    open func cancelAll(
        type: ImageProgressMemoryCacheCacheType
    ) {
        if type.contains(.original) {
            originalTask.resetAll(
                cancelForAllWaiters: true
            )
        }

        if type.contains(.resized) {
            resizedTask.resetAll(
                cancelForAllWaiters: true
            )
        }
    }
}
