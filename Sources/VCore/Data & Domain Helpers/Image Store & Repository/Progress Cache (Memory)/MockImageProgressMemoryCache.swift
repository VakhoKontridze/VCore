//
//  MockImageProgressMemoryCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if canImport(UIKit)
public import UIKit
#elseif canImport(AppKit)
public import AppKit
#endif

/// Mock image progress memory cache.
nonisolated open class MockImageProgressMemoryCache: ImageProgressMemoryCache, @unchecked Sendable {
    // MARK: Initializers
    /// Initializes `MockImageProgressMemoryCache`.
    public init() {}

    // MARK: Operation - Run
    /// Runs operation for original image.
    open func run(
        key: ImageProgressMemoryCacheOriginalKey,
        operation: @Sendable @escaping () async throws -> PlatformImage
    ) async throws -> PlatformImage {
        try await operation()
    }

    /// Runs operation for resized image.
    open func run(
        key: ImageProgressMemoryCacheResizedKey,
        operation: @Sendable @escaping () async throws -> PlatformImage
    ) async throws -> PlatformImage {
        try await operation()
    }

    // MARK: Operation - Cancel
    /// Cancels in-flight original image.
    open func cancel(
        key: ImageProgressMemoryCacheOriginalKey
    ) {}

    /// Cancels in-flight resized image.
    open func cancel(
        key: ImageProgressMemoryCacheResizedKey,
        cancelAllSizes: Bool
    ) {}

    // MARK: Operation - Cancel All
    /// Cancels all in-flight images.
    open func cancelAll(
        type: ImageProgressMemoryCacheCacheType
    ) {}
}
