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
    
    // MARK: Operation - Get
    /// Gets original image.
    open func get(
        key: ImageProgressMemoryCacheOriginalKey
    ) -> Task<PlatformImage, any Error>? {
        nil
    }
    
    /// Gets resized image.
    open func get(
        key: ImageProgressMemoryCacheResizedKey
    ) -> Task<PlatformImage, any Error>? {
        nil
    }
    
    // MARK: Operation - Set
    /// Sets original image.
    open func set(
        key: ImageProgressMemoryCacheOriginalKey,
        task: Task<PlatformImage, any Error>
    ) {}
    
    /// Sets resized image.
    open func set(
        key: ImageProgressMemoryCacheResizedKey,
        task: Task<PlatformImage, any Error>
    ) {}
    
    // MARK: Operation - Delete
    /// Deletes original image.
    open func delete(
        key: ImageProgressMemoryCacheOriginalKey,
        cancel: Bool
    ) {}
    
    /// Deletes resized image.
    open func delete(
        key: ImageProgressMemoryCacheResizedKey,
        deleteAllSizes: Bool,
        cancel: Bool
    ) {}
    
    // MARK: Operation - Delete All
    /// Deletes all images.
    open func deleteAll(
        type: ImageProgressMemoryCacheCacheType,
        cancel: Bool
    ) {}
}
