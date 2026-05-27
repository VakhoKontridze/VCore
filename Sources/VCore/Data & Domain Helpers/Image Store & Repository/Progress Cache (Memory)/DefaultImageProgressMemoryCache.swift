//
//  DefaultImageProgressMemoryCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Default image progress memory cache.
nonisolated public final class DefaultImageProgressMemoryCache: ImageProgressMemoryCache, @unchecked Sendable {
    // MARK: Properties - Cache & Keys
    private let originalCache: NSCache<ImageProgressMemoryCacheOriginalKey, TaskHolder>
    private var originalCacheKeys: Set<ImageProgressMemoryCacheOriginalKey> = []
    
    private let resizedCache: NSCache<ImageProgressMemoryCacheResizedKey, TaskHolder>
    private var resizedCacheKeys: Set<ImageProgressMemoryCacheResizedKey> = []
    
    // MARK: Properties - Queue
    private let queue: DispatchQueue = .init(
        label: "com.vakhtang-kontridze.vcore.default-image-progress-memory-cache",
        attributes: .concurrent
    )
    
    // MARK: Initializers
    /// Initializes `DefaultImageProgressMemoryCache`.
    public init(
        originalCacheConfiguration: Configuration = .default,
        resizedCacheConfiguration: Configuration = .default
    ) {
        self.originalCache = {
            let cache: NSCache<ImageProgressMemoryCacheOriginalKey, TaskHolder> = .init()
            cache.countLimit = originalCacheConfiguration.countLimit
            return cache
        }()
        
        self.resizedCache = {
            let cache: NSCache<ImageProgressMemoryCacheResizedKey, TaskHolder> = .init()
            cache.countLimit = resizedCacheConfiguration.countLimit
            return cache
        }()
    }
    
    // MARK: Operation - Get
    public func get(
        key: ImageProgressMemoryCacheOriginalKey
    ) -> Task<PlatformImage, any Error>? {
        queue.sync {
            _get(
                key: key
            )
        }
    }
    
    private func _get(
        key: ImageProgressMemoryCacheOriginalKey
    ) -> Task<PlatformImage, any Error>? {
        originalCache.object(forKey: key)?.task
    }
    
    public func get(
        key: ImageProgressMemoryCacheResizedKey
    ) -> Task<PlatformImage, any Error>? {
        queue.sync {
            _get(
                key: key
            )
        }
    }

    private func _get(
        key: ImageProgressMemoryCacheResizedKey
    ) -> Task<PlatformImage, any Error>? {
        resizedCache.object(forKey: key)?.task
    }
    
    // MARK: Operation - Set
    public func set(
        key: ImageProgressMemoryCacheOriginalKey,
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
        key: ImageProgressMemoryCacheResizedKey,
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
        key: ImageProgressMemoryCacheOriginalKey,
        cancel: Bool
    ) {
        queue.sync(flags: .barrier) {
            _delete(
                key: key,
                cancel: cancel
            )
        }
    }
    
    private func _delete(
        key: ImageProgressMemoryCacheOriginalKey,
        cancel: Bool
    ) {
        if
            cancel,
            let task: Task<PlatformImage, any Error> = _get(key: key)
        {
            task.cancel()
        }
        
        originalCache.removeObject(forKey: key)
        originalCacheKeys.remove(key)
    }
    
    public func delete(
        key: ImageProgressMemoryCacheResizedKey,
        deleteAllSizes: Bool,
        cancel: Bool
    ) {
        queue.sync(flags: .barrier) {
            _delete(
                key: key,
                deleteAllSizes: deleteAllSizes,
                cancel: cancel
            )
        }
    }
    
    private func _delete(
        key: ImageProgressMemoryCacheResizedKey,
        deleteAllSizes: Bool,
        cancel: Bool
    ) {
        if
            cancel,
            let task: Task<PlatformImage, any Error> = _get(key: key)
        {
            task.cancel()
        }
        
        if deleteAllSizes {
            let keys: [ImageProgressMemoryCacheResizedKey] = resizedCacheKeys.filter { $0.parameter == key.parameter }
            
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
        type: ImageProgressMemoryCacheCacheType,
        cancel: Bool
    ) {
        queue.sync(flags: .barrier) {
            if type.contains(.original) {
                let keys: Set<ImageProgressMemoryCacheOriginalKey> = originalCacheKeys
                for key in keys {
                    _delete(
                        key: key,
                        cancel: cancel
                    )
                }
            }
            
            if type.contains(.resized) {
                let keys: Set<ImageProgressMemoryCacheResizedKey> = resizedCacheKeys
                for key in keys {
                    _delete(
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
