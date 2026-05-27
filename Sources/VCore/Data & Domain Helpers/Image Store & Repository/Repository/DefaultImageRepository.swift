//
//  DefaultImageRepository.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
import OSLog

/// Default mage repository.
nonisolated public final class DefaultImageRepository: ImageRepository {
    // MARK: Properties - Dependencies
    public let imageFetchWorker: any ImageRepositoryFetchWorker
    
    public let imageMemoryCache: any ImageMemoryCache
    public let imageDiskCache: any ImageDiskCache
    
    public let imageProgressMemoryCache: any ImageProgressMemoryCache
    
    // MARK: Initializers
    /// Initializes `DefaultImageRepository`.
    public init(
        imageFetchWorker: any ImageRepositoryFetchWorker,
        imageMemoryCache: any ImageMemoryCache,
        imageDiskCache: any ImageDiskCache,
        imageProgressMemoryCache: any ImageProgressMemoryCache
    ) {
        self.imageFetchWorker = imageFetchWorker
        self.imageMemoryCache = imageMemoryCache
        self.imageDiskCache = imageDiskCache
        self.imageProgressMemoryCache = imageProgressMemoryCache
    }
    
    // MARK: Operations
    public func fetchOriginalImage(
        parameter: ImageRepositoryParameter,
        cachePolicy: ImageRepositoryCachePolicy,
        cacheStorage: ImageRepositoryCacheStorage,
        progressCacheStorage: ImageRepositoryProgressCacheStorage?
    ) async throws -> PlatformImage {
        try await _fetchImage(
            parameter: parameter,
            
            memoryCacheKey: .original(
                ImageMemoryCacheOriginalKey(
                    parameter: parameter
                )
            ),
            diskCacheKey: .original(
                ImageDiskCacheOriginalKey(
                    parameter: parameter
                )
            ),
            progressMemoryCacheKey: .original(
                ImageProgressMemoryCacheOriginalKey(
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
        parameter: ImageRepositoryParameter,
        size: CGSize,
        cachePolicy: ImageRepositoryCachePolicy,
        cacheStorage: ImageRepositoryCacheStorage,
        progressCacheStorage: ImageRepositoryProgressCacheStorage?,
        imageVariantCachingPolicy: ImageRepositoryResizedImageVariantCachingPolicy
    ) async throws -> PlatformImage {
        try await _fetchImage(
            parameter: parameter,
            
            memoryCacheKey: .resized(
                ImageMemoryCacheResizedKey(
                    parameter: parameter,
                    size: size
                )
            ),
            diskCacheKey: .resized(
                ImageDiskCacheResizedKey(
                    parameter: parameter,
                    size: size
                )
            ),
            progressMemoryCacheKey: .resized(
                ImageProgressMemoryCacheResizedKey(
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
                        ImageMemoryCacheOriginalKey(
                            parameter: parameter
                        )
                    ),
                    diskCacheKey: .original(
                        ImageDiskCacheOriginalKey(
                            parameter: parameter
                        )
                    ),
                    progressMemoryCacheKey: .original(
                        ImageProgressMemoryCacheOriginalKey(
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
        parameter: ImageRepositoryParameter,
        
        memoryCacheKey: Key<ImageMemoryCacheOriginalKey, ImageMemoryCacheResizedKey>,
        diskCacheKey: Key<ImageDiskCacheOriginalKey, ImageDiskCacheResizedKey>,
        progressMemoryCacheKey: Key<ImageProgressMemoryCacheOriginalKey, ImageProgressMemoryCacheResizedKey>,
        
        cachePolicy: ImageRepositoryCachePolicy,
        cachePolicy_WritesToCache: Bool = true,
        cacheStorage: ImageRepositoryCacheStorage,
        progressCacheStorage: ImageRepositoryProgressCacheStorage?,
        
        fetchImage: @escaping @Sendable (ImageRepositoryParameter) async throws -> PlatformImage
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
#if canImport(UIKit)
                        Logger.imageStoreAndRepository.warning("Misuse of 'DefaultImageRepository'. Raw 'UIImage' has no stable disk identity. Writing to disk is a no-op, as the key won't survive relaunch.")
#elseif canImport(AppKit)
                        Logger.imageStoreAndRepository.warning("Misuse of 'DefaultImageRepository'. Raw 'NSImage' has no stable disk identity. Writing to disk is a no-op, as the key won't survive relaunch.")
#endif
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
        progressCacheStorage: ImageRepositoryProgressCacheStorage?,
        progressMemoryCacheKey: Key<ImageProgressMemoryCacheOriginalKey, ImageProgressMemoryCacheResizedKey>,
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
        parameter: ImageRepositoryParameter,
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
#if canImport(UIKit)

        guard
            let thumbnail: PlatformImage = await image.byPreparingThumbnail(ofSize: size)
        else {
            throw ImageRepositoryError.failedToResizeImage
        }
        try Task.checkCancellation()
        
#elseif canImport(AppKit)

        guard
            let thumbnail: PlatformImage = image.byPreparingThumbnail(ofSize: size)
        else {
            throw ImageRepositoryError.failedToResizeImage
        }
#endif
        
        return thumbnail
    }
    
    // MARK: Types
    nonisolated private enum Key<Original, Resized> {
        case original(Original)
        case resized(Resized)
    }
}
