//
//  MockImageProgressMemoryCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if DEBUG

import Foundation

/// Mock image progress memory cache.
public actor MockImageProgressMemoryCache: ImageProgressMemoryCacheProtocol {
    // MARK: Initializers
    /// Initializes `MockImageProgressMemoryCache`.
    public init() {}
    
    // MARK: Operations
    public func get(
        key: ImageProgressMemoryCache_OriginalKey
    ) -> Task<PlatformImage, any Error>? {
        nil
    }
    
    public func get(
        key: ImageProgressMemoryCache_ResizedKey
    ) -> Task<PlatformImage, any Error>? {
        nil
    }
    
    public func set(
        key: ImageProgressMemoryCache_OriginalKey,
        task: Task<PlatformImage, any Error>
    ) {}
    
    public func set(
        key: ImageProgressMemoryCache_ResizedKey,
        task: Task<PlatformImage, any Error>
    ) {}
    
    public func delete(
        key: ImageProgressMemoryCache_OriginalKey,
        cancel: Bool
    ) {}
    
    public func delete(
        key: ImageProgressMemoryCache_ResizedKey,
        cancel: Bool
    ) {}
    
    public func deleteAll(
        type: ImageProgressMemoryCache_CacheType,
        cancel: Bool
    ) {}
}

#endif
