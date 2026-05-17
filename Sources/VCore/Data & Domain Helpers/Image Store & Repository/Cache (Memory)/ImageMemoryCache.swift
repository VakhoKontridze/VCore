//
//  ImageMemoryCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import Foundation

/// Image memory cache.
public actor ImageMemoryCache: ImageMemoryCacheProtocol {
    // MARK: Properties
    private let originalCache: NSCache<ImageMemoryCache_OriginalKey, PlatformImage>
    private var originalCacheKeys: Set<ImageMemoryCache_OriginalKey> = []
    
    private let resizedCache: NSCache<ImageMemoryCache_ResizedKey, PlatformImage>
    private var resizedCacheKeys: Set<ImageMemoryCache_ResizedKey> = []
    
    // MARK: Initializers
    /// Initializes `ImageMemoryCache`.
    public init(
        cacheOriginalConfiguration: ImageMemoryCacheConfiguration = .defaultMemoryOriginal,
        cacheResizedConfiguration: ImageMemoryCacheConfiguration = .defaultMemoryResized
    ) {
        self.originalCache = {
            let cache: NSCache<ImageMemoryCache_OriginalKey, PlatformImage> = .init()
            cache.countLimit = cacheOriginalConfiguration.countLimit
            cache.totalCostLimit = cacheOriginalConfiguration.totalCostLimit
            return cache
        }()
        
        self.resizedCache = {
            let cache: NSCache<ImageMemoryCache_ResizedKey, PlatformImage> = .init()
            cache.countLimit = cacheResizedConfiguration.countLimit
            cache.totalCostLimit = cacheResizedConfiguration.totalCostLimit
            return cache
        }()
    }
    
    // MARK: Operation - Get
    public func get(
        key: ImageMemoryCache_OriginalKey
    ) -> PlatformImage? {
        originalCache.object(forKey: key)
    }
    
    public func get(
        key: ImageMemoryCache_ResizedKey
    ) -> PlatformImage? {
        resizedCache.object(forKey: key)
    }
    
    // MARK: Operation - Set
    public func set(
        key: ImageMemoryCache_OriginalKey,
        image: PlatformImage
    ) {
        originalCache.setObject(
            image,
            forKey: key,
            cost: image.cacheCost
        )
        originalCacheKeys.insert(key)
    }
    
    public func set(
        key: ImageMemoryCache_ResizedKey,
        image: PlatformImage
    ) {
        resizedCache.setObject(
            image,
            forKey: key,
            cost: image.cacheCost
        )
        resizedCacheKeys.insert(key)
    }

    // MARK: Operation - Delete
    public func delete(
        key: ImageMemoryCache_OriginalKey
    ) {
        originalCache.removeObject(forKey: key)
        originalCacheKeys.remove(key)
    }
    
    public func delete(
        key: ImageMemoryCache_ResizedKey,
        deleteAllSizes: Bool,
    ) {
        if deleteAllSizes {
            let keys: [ImageMemoryCache_ResizedKey] = resizedCacheKeys.filter { $0.parameter == key.parameter }
            
            for key in keys {
                resizedCache.removeObject(forKey: key)
                resizedCacheKeys.remove(key)
            }
            
        } else {
            resizedCache.removeObject(forKey: key)
            resizedCacheKeys.remove(key)
        }
    }
    
    // MARK: Operation - Delete All
    public func deleteAll(
        type: ImageMemoryCache_CacheType
    ) {
        if type.contains(.original) {
            originalCache.removeAllObjects()
        }
        
        if type.contains(.resized) {
            resizedCache.removeAllObjects()
        }
    }
}
