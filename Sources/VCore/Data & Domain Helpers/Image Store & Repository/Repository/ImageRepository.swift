//
//  ImageRepository.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import Foundation
import OSLog

/// Image repository.
nonisolated public final class ImageRepository: ImageRepositoryProtocol {
    // MARK: Properties - Dependencies
    public let imageFetchWorker: any ImageRepositoryFetchWorkerProtocol
    
    public let imageMemoryCache: any ImageMemoryCacheProtocol
    public let imageDiskCache: any ImageDiskCacheProtocol
    
    public let imageProgressMemoryCache: any ImageProgressMemoryCacheProtocol
    
    // MARK: Initializers
    /// Initializes `ImageRepository`.
    public init(
        imageFetchWorker: any ImageRepositoryFetchWorkerProtocol,
        imageMemoryCache: any ImageMemoryCacheProtocol,
        imageDiskCache: any ImageDiskCacheProtocol,
        imageProgressMemoryCache: any ImageProgressMemoryCacheProtocol
    ) {
        self.imageFetchWorker = imageFetchWorker
        self.imageMemoryCache = imageMemoryCache
        self.imageDiskCache = imageDiskCache
        self.imageProgressMemoryCache = imageProgressMemoryCache
    }
    
    // MARK: Operations
    public func fetchOriginalImage(
        parameter: ImageRepository_Parameter,
        cachePolicy: ImageRepository_CachePolicy,
        cacheStorage: ImageRepository_CacheStorage,
        progressCacheStorage: ImageRepository_ProgressCacheStorage?
    ) async throws -> PlatformImage {
        try await _fetchImage(
            parameter: parameter,
            
            memoryCacheKey: .original(
                ImageMemoryCache_OriginalKey(
                    parameter: parameter
                )
            ),
            diskCacheKey: .original(
                ImageDiskCache_OriginalKey(
                    parameter: parameter
                )
            ),
            progressMemoryCacheKey: .original(
                ImageProgressMemoryCache_OriginalKey(
                    parameter: parameter
                )
            ),
            
            cachePolicy: cachePolicy,
            cacheStorage: cacheStorage,
            progressCacheStorage: progressCacheStorage,
            
            fetchImage: { [weak self] parameter in
                guard let self else { throw CancellationError() }
             
                return try await fetchImage(parameter: parameter)
            }
        )
    }
    
    public func fetchResizedImage(
        parameter: ImageRepository_Parameter,
        size: CGSize,
        cachePolicy: ImageRepository_CachePolicy,
        cacheStorage: ImageRepository_CacheStorage,
        progressCacheStorage: ImageRepository_ProgressCacheStorage?,
        imageVariantCachingPolicy: ImageRepository_ResizedImageVariantCachingPolicy
    ) async throws -> PlatformImage {
        try await _fetchImage(
            parameter: parameter,
            
            memoryCacheKey: .resized(
                ImageMemoryCache_ResizedKey(
                    parameter: parameter,
                    size: size
                )
            ),
            diskCacheKey: .resized(
                ImageDiskCache_ResizedKey(
                    parameter: parameter,
                    size: size
                )
            ),
            progressMemoryCacheKey: .resized(
                ImageProgressMemoryCache_ResizedKey(
                    parameter: parameter,
                    size: size
                )
            ),
            
            cachePolicy: cachePolicy,
            cachePolicy_WritesToCache: imageVariantCachingPolicy.contains(.resized),
            cacheStorage: cacheStorage,
            progressCacheStorage: progressCacheStorage,
            
            fetchImage: { [weak self] parameter in
                guard let self else { throw CancellationError() }
                
                let originalImage: PlatformImage = try await _fetchImage(
                    parameter: parameter,
                    
                    memoryCacheKey: .original(
                        ImageMemoryCache_OriginalKey(
                            parameter: parameter
                        )
                    ),
                    diskCacheKey: .original(
                        ImageDiskCache_OriginalKey(
                            parameter: parameter
                        )
                    ),
                    progressMemoryCacheKey: .original(
                        ImageProgressMemoryCache_OriginalKey(
                            parameter: parameter
                        )
                    ),
                    
                    cachePolicy: .useCache,
                    cachePolicy_WritesToCache: imageVariantCachingPolicy.contains(.original),
                    cacheStorage: cacheStorage,
                    progressCacheStorage: progressCacheStorage,
                    
                    fetchImage: fetchImage
                )
                try Task.checkCancellation()
                
                let resizedImage: PlatformImage = try await makeThumbnail(
                    image: originalImage,
                    size: size
                )
                try Task.checkCancellation()
                
                return resizedImage
            }
        )
    }
    
    private func _fetchImage(
        parameter: ImageRepository_Parameter,
        
        memoryCacheKey: Key<ImageMemoryCache_OriginalKey, ImageMemoryCache_ResizedKey>,
        diskCacheKey: Key<ImageDiskCache_OriginalKey, ImageDiskCache_ResizedKey>,
        progressMemoryCacheKey: Key<ImageProgressMemoryCache_OriginalKey, ImageProgressMemoryCache_ResizedKey>,
        
        cachePolicy: ImageRepository_CachePolicy,
        cachePolicy_WritesToCache: Bool = true,
        cacheStorage: ImageRepository_CacheStorage,
        progressCacheStorage: ImageRepository_ProgressCacheStorage?,
        
        fetchImage: @escaping @Sendable (ImageRepository_Parameter) async throws -> PlatformImage
    ) async throws -> PlatformImage {
        // 1. Reads from cache
        if cachePolicy.readsFromCache {
            if cacheStorage.contains(.memory) {
                let image: PlatformImage? = {
                    switch memoryCacheKey {
                    case .original(let key): imageMemoryCache.get(key: key)
                    case .resized(let key): imageMemoryCache.get(key: key)
                    }
                }()

                if let image {
                    return image
                }
            }
            
            if cacheStorage.contains(.disk) {
                let image: PlatformImage? = {
                    switch diskCacheKey {
                    case .original(let key): imageDiskCache.get(key: key)
                    case .resized(let key): imageDiskCache.get(key: key)
                    }
                }()
                
                if let image {
                    if cacheStorage.contains(.memory) {
                        switch memoryCacheKey {
                        case .original(let key): imageMemoryCache.set(key: key, image: image)
                        case .resized(let key): imageMemoryCache.set(key: key, image: image)
                        }
                    }
                    
                    return image
                }
            }
        }
        
        // 2. Reads from progress cache
        switch progressCacheStorage {
        case .memory:
            let task: Task<PlatformImage, any Error>? = {
                switch progressMemoryCacheKey {
                case .original(let key): imageProgressMemoryCache.get(key: key)
                case .resized(let key): imageProgressMemoryCache.get(key: key)
                }
            }()
            
            if let task {
                let image: PlatformImage = try await task.value
                try Task.checkCancellation()
                
                return image
            }
            
        case nil:
            break
        }
        
        // 3a. Fetches - initial checks
        if !cachePolicy.fetches {
            throw ImageRepositoryError.imageNotInCache
        }
        
        // 3b - 4
        // NOTE: This needs to be grouped as one, since `defer` doesn't work with `await`
        do {
            // 3b. Fetches - schedules and registers work
            let task: Task<PlatformImage, any Error> = .init {
                try await fetchImage(parameter)
            }
            
            // 3c. Fetches - saves and clears progress
            switch progressCacheStorage {
            case .memory:
                switch progressMemoryCacheKey {
                case .original(let key): imageProgressMemoryCache.set(key: key, task: task)
                case .resized(let key): imageProgressMemoryCache.set(key: key, task: task)
                }
                
            case nil:
                break
            }
            
            // 3d. Fetches - gets image
            let image: PlatformImage = try await task.value
            try Task.checkCancellation()
            
            // 3e. Fetches - saves image
            if cachePolicy_WritesToCache {
                if cacheStorage.contains(.memory) {
                    switch memoryCacheKey {
                    case .original(let key): imageMemoryCache.set(key: key, image: image)
                    case .resized(let key): imageMemoryCache.set(key: key, image: image)
                    }
                }
                
                if cacheStorage.contains(.disk) {
                    if parameter.diskIdentifier == nil {
                        Logger.imageStoreAndRepository.warning("Raw `PlatformImage` has no stable disk identity. Writing to disk is a no-op, as the key won't survive relaunch.")
                    }
                    
                    switch diskCacheKey {
                    case .original(let key): imageDiskCache.set(key: key, image: image)
                    case .resized(let key): imageDiskCache.set(key: key, image: image)
                    }
                }
            }
            
            // 3f. Fetches - clears progress
            await __clearProgress(
                progressCacheStorage: progressCacheStorage,
                progressMemoryCacheKey: progressMemoryCacheKey,
                cancel: false
            )
            try Task.checkCancellation()
            
            // 4. Result
            return image
            
        } catch {
            await __clearProgress(
                progressCacheStorage: progressCacheStorage,
                progressMemoryCacheKey: progressMemoryCacheKey,
                cancel: error is CancellationError
            )
            //try Task.checkCancellation()
            
            throw error
        }
    }
    
    private func __clearProgress(
        progressCacheStorage: ImageRepository_ProgressCacheStorage?,
        progressMemoryCacheKey: Key<ImageProgressMemoryCache_OriginalKey, ImageProgressMemoryCache_ResizedKey>,
        cancel: Bool
    ) async {
        switch progressCacheStorage {
        case .memory:
            switch progressMemoryCacheKey {
            case .original(let key): imageProgressMemoryCache.delete(key: key, cancel: cancel)
            case .resized(let key): imageProgressMemoryCache.delete(key: key, deleteAllSizes: true, cancel: cancel)
            }
            
        case nil:
            break
        }
    }
    
    // MARK: Helpers
    private func fetchImage(
        parameter: ImageRepository_Parameter,
    ) async throws -> PlatformImage {
        switch parameter.storage {
        case .image(let image):
            try await imageFetchWorker.fetchImage(image: image)
        
        case .data(let data):
            try await imageFetchWorker.fetchImage(data: data)
            
        case .asset(let name, let bundle):
            try await imageFetchWorker.fetchAssetImage(name: name, bundle: bundle)
        
        case .local(let url):
            try await imageFetchWorker.fetchLocalImage(url: url)
        
        case .remote(let url):
            try await imageFetchWorker.fetchRemoteImage(url: url)
            
        case .photo_Asset(let asset):
            try await imageFetchWorker.fetchPhotoImage(asset: asset)
            
        case .photo_Item(let item):
            try await imageFetchWorker.fetchPhotoImage(item: item)
            
        case .photo_AssetIdentifier(let assetIdentifier):
            try await imageFetchWorker.fetchPhotoImage(assetIdentifier: assetIdentifier)
        }
    }
    
    private func makeThumbnail(
        image: PlatformImage,
        size: CGSize
    ) async throws -> PlatformImage {
        guard
            let thumbnail: PlatformImage = await image.byPreparingThumbnail(ofSize: size)
        else {
            throw ImageRepositoryError.failedToResizeImage
        }
        
        return thumbnail
    }
    
    // MARK: Types
    nonisolated private enum Key<Original, Resized> {
        case original(Original)
        case resized(Resized)
    }
}
