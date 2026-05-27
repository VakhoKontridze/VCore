//
//  DefaultImageMemoryCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Default image memory cache.
nonisolated open class DefaultImageMemoryCache: ImageMemoryCache, @unchecked Sendable {
    // MARK: Properties - Cache and Keys
    private let originalCache: NSCache<ImageMemoryCacheOriginalKey, PlatformImage>
    private var originalCacheKeys: Set<ImageMemoryCacheOriginalKey> = []
    
    private let resizedCache: NSCache<ImageMemoryCacheResizedKey, PlatformImage>
    private var resizedCacheKeys: Set<ImageMemoryCacheResizedKey> = []
    
    // MARK: Properties - Queue
    private let queue: DispatchQueue = .init(
        label: "com.vakhtang-kontridze.vcore.default-image-memory-cache",
        attributes: .concurrent
    )
    
    // MARK: Initializers
    /// Initializes `DefaultImageMemoryCache`.
    public init(
        cacheOriginalConfiguration: Configuration = .defaultMemoryOriginal,
        cacheResizedConfiguration: Configuration = .defaultMemoryResized
    ) {
        self.originalCache = {
            let cache: NSCache<ImageMemoryCacheOriginalKey, PlatformImage> = .init()
            cache.countLimit = cacheOriginalConfiguration.countLimit
            cache.totalCostLimit = cacheOriginalConfiguration.totalCostLimit
            return cache
        }()
        
        self.resizedCache = {
            let cache: NSCache<ImageMemoryCacheResizedKey, PlatformImage> = .init()
            cache.countLimit = cacheResizedConfiguration.countLimit
            cache.totalCostLimit = cacheResizedConfiguration.totalCostLimit
            return cache
        }()
    }
    
    // MARK: Operation - Get
    open func get(
        key: ImageMemoryCacheOriginalKey
    ) -> PlatformImage? {
        queue.sync {
            originalCache.object(forKey: key)
        }
    }
    
    open func get(
        key: ImageMemoryCacheResizedKey
    ) -> PlatformImage? {
        queue.sync {
            resizedCache.object(forKey: key)
        }
    }
    
    // MARK: Operation - Set
    open func set(
        key: ImageMemoryCacheOriginalKey,
        image: PlatformImage
    ) {
        queue.sync(flags: .barrier) {
            originalCache.setObject(
                image,
                forKey: key,
                cost: image.cacheCost
            )
            originalCacheKeys.insert(key)
        }
    }
    
    open func set(
        key: ImageMemoryCacheResizedKey,
        image: PlatformImage
    ) {
        queue.sync(flags: .barrier) {
            resizedCache.setObject(
                image,
                forKey: key,
                cost: image.cacheCost
            )
            resizedCacheKeys.insert(key)
        }
    }

    // MARK: Operation - Delete
    open func delete(
        key: ImageMemoryCacheOriginalKey
    ) {
        queue.sync(flags: .barrier) {
            originalCache.removeObject(forKey: key)
            originalCacheKeys.remove(key)
        }
    }
    
    open func delete(
        key: ImageMemoryCacheResizedKey,
        deleteAllSizes: Bool,
    ) {
        queue.sync(flags: .barrier) {
            if deleteAllSizes {
                let keys: [ImageMemoryCacheResizedKey] = resizedCacheKeys.filter { $0.parameter == key.parameter }
                
                for key in keys {
                    resizedCache.removeObject(forKey: key)
                    resizedCacheKeys.remove(key)
                }
                
            } else {
                resizedCache.removeObject(forKey: key)
                resizedCacheKeys.remove(key)
            }
        }
    }
    
    // MARK: Operation - Delete All
    open func deleteAll(
        type: ImageMemoryCacheCacheType
    ) {
        queue.sync(flags: .barrier) {
            if type.contains(.original) {
                originalCache.removeAllObjects()
                originalCacheKeys.removeAll()
            }
            
            if type.contains(.resized) {
                resizedCache.removeAllObjects()
                resizedCacheKeys.removeAll()
            }
        }
    }
}
