//
//  MockImageProgressMemoryCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if DEBUG

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
    
    // MARK: Operations
    open func get(
        key: ImageProgressMemoryCacheOriginalKey
    ) -> Task<PlatformImage, any Error>? {
        nil
    }
    
    open func get(
        key: ImageProgressMemoryCacheResizedKey
    ) -> Task<PlatformImage, any Error>? {
        nil
    }
    
    open func set(
        key: ImageProgressMemoryCacheOriginalKey,
        task: Task<PlatformImage, any Error>
    ) {}
    
    open func set(
        key: ImageProgressMemoryCacheResizedKey,
        task: Task<PlatformImage, any Error>
    ) {}
    
    open func delete(
        key: ImageProgressMemoryCacheOriginalKey,
        cancel: Bool
    ) {}
    
    open func delete(
        key: ImageProgressMemoryCacheResizedKey,
        deleteAllSizes: Bool,
        cancel: Bool
    ) {}
    
    open func deleteAll(
        type: ImageProgressMemoryCacheCacheType,
        cancel: Bool
    ) {}
}

#endif
