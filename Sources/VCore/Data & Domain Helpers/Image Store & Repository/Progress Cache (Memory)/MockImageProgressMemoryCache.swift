//
//  MockImageProgressMemoryCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if DEBUG

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Mock image progress memory cache.
nonisolated public final class MockImageProgressMemoryCache: ImageProgressMemoryCache {
    // MARK: Initializers
    /// Initializes `MockImageProgressMemoryCache`.
    public init() {}
    
    // MARK: Operations
    public func get(
        key: ImageProgressMemoryCacheOriginalKey
    ) -> Task<PlatformImage, any Error>? {
        nil
    }
    
    public func get(
        key: ImageProgressMemoryCacheResizedKey
    ) -> Task<PlatformImage, any Error>? {
        nil
    }
    
    public func set(
        key: ImageProgressMemoryCacheOriginalKey,
        task: Task<PlatformImage, any Error>
    ) {}
    
    public func set(
        key: ImageProgressMemoryCacheResizedKey,
        task: Task<PlatformImage, any Error>
    ) {}
    
    public func delete(
        key: ImageProgressMemoryCacheOriginalKey,
        cancel: Bool
    ) {}
    
    public func delete(
        key: ImageProgressMemoryCacheResizedKey,
        deleteAllSizes: Bool,
        cancel: Bool
    ) {}
    
    public func deleteAll(
        type: ImageProgressMemoryCacheCacheType,
        cancel: Bool
    ) {}
}

#endif
