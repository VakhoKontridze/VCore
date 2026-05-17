//
//  ImageProgressMemoryCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import Foundation

/// Image progress memory cache.
public final class ImageProgressMemoryCache: ImageProgressMemoryCacheProtocol, @unchecked Sendable {
    // MARK: Properties - Cache & Keys
    private let originalCache: NSCache<ImageProgressMemoryCache_OriginalKey, TaskHolder>
    private var originalCacheKeys: Set<ImageProgressMemoryCache_OriginalKey> = []
    
    private let resizedCache: NSCache<ImageProgressMemoryCache_ResizedKey, TaskHolder>
    private var resizedCacheKeys: Set<ImageProgressMemoryCache_ResizedKey> = []
    
    // MARK: Properties - Queue
    private let queue: DispatchQueue = .init(
        label: "com.vakhtang-kontridze.vcore.image-progress-memory-cache",
        attributes: .concurrent
    )
    
    // MARK: Initializers
    /// Initializes `ImageProgressMemoryCache`.
    public init(
        originalCacheConfiguration: ImageProgressMemoryCacheConfiguration = .default,
        resizedCacheConfiguration: ImageProgressMemoryCacheConfiguration = .default
    ) {
        self.originalCache = {
            let cache: NSCache<ImageProgressMemoryCache_OriginalKey, TaskHolder> = .init()
            cache.countLimit = originalCacheConfiguration.countLimit
            return cache
        }()
        
        self.resizedCache = {
            let cache: NSCache<ImageProgressMemoryCache_ResizedKey, TaskHolder> = .init()
            cache.countLimit = resizedCacheConfiguration.countLimit
            return cache
        }()
    }
    
    // MARK: Operation - Get
    public func get(
        key: ImageProgressMemoryCache_OriginalKey
    ) -> Task<PlatformImage, any Error>? {
        queue.sync {
            originalCache.object(forKey: key)?.task
        }
    }
    
    public func get(
        key: ImageProgressMemoryCache_ResizedKey
    ) -> Task<PlatformImage, any Error>? {
        queue.sync {
            resizedCache.object(forKey: key)?.task
        }
    }
    
    // MARK: Operation - Set
    public func set(
        key: ImageProgressMemoryCache_OriginalKey,
        task: Task<PlatformImage, any Error>
    ) {
        queue.sync(flags: .barrier) {
            originalCache.setObject(
                TaskHolder(task),
                forKey: key
            )
            originalCacheKeys.insert(key)
        }
    }
    
    public func set(
        key: ImageProgressMemoryCache_ResizedKey,
        task: Task<PlatformImage, any Error>
    ) {
        queue.sync(flags: .barrier) {
            resizedCache.setObject(
                TaskHolder(task),
                forKey: key
            )
            resizedCacheKeys.insert(key)
        }
    }

    // MARK: Operation - Delete
    public func delete(
        key: ImageProgressMemoryCache_OriginalKey,
        cancel: Bool
    ) {
        queue.sync(flags: .barrier) {
            if
                cancel,
                let task: Task<PlatformImage, any Error> = get(key: key)
            {
                task.cancel()
            }
            
            originalCache.removeObject(forKey: key)
            originalCacheKeys.remove(key)
        }
    }
    
    public func delete(
        key: ImageProgressMemoryCache_ResizedKey,
        deleteAllSizes: Bool,
        cancel: Bool
    ) {
        queue.sync(flags: .barrier) {
            if
                cancel,
                let task: Task<PlatformImage, any Error> = get(key: key)
            {
                task.cancel()
            }
            
            if deleteAllSizes {
                let keys: [ImageProgressMemoryCache_ResizedKey] = resizedCacheKeys.filter { $0.parameter == key.parameter }
                
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
    public func deleteAll(
        type: ImageProgressMemoryCache_CacheType,
        cancel: Bool
    ) {
        queue.sync(flags: .barrier) {
            if type.contains(.original) {
                let keys: Set<ImageProgressMemoryCache_OriginalKey> = originalCacheKeys
                for key in keys {
                    delete(
                        key: key,
                        cancel: cancel
                    )
                }
            }
            
            if type.contains(.resized) {
                let keys: Set<ImageProgressMemoryCache_ResizedKey> = resizedCacheKeys
                for key in keys {
                    delete(
                        key: key,
                        deleteAllSizes: false,
                        cancel: cancel
                    )
                }
            }
        }
    }
    
    // MARK: Types
    nonisolated private final class TaskHolder {
        // MARK: Properties
        let task: Task<PlatformImage, any Error>

        // MARK: Initializers
        init(_ task: Task<PlatformImage, any Error>) {
            self.task = task
        }
    }
}
