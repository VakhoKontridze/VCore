//
//  DefaultImageRepository.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if canImport(UIKit)
public import UIKit
#elseif canImport(AppKit)
public import AppKit
#endif
import OSLog

/// Default mage repository.
nonisolated open class DefaultImageRepository: ImageRepository, @unchecked Sendable {
    // MARK: Properties - Dependencies
    /// Image fetch worker.
    public let imageFetchWorker: any ImageRepositoryFetchWorker
    
    /// Image memory cache.
    public let imageMemoryCache: any ImageMemoryCache
    
    /// Image disk cache.
    public let imageDiskCache: any ImageDiskCache
    
    /// Image progress memory cache.
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
    /// Fetches original image.
    open func fetchOriginalImage(
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
    
    /// Fetches resized image.
    open func fetchResizedImage(
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
    
    @concurrent
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
                    // Disk images decode lazily, so bitmap is prepared here, rather than on the first draw
                    let preparedImage: PlatformImage = await prepareForDisplay(image: image)
                    try Task.checkCancellation()

                    if cacheStorage.contains(.memory) {
                        switch memoryCacheKey {
                        case .original(let key): imageMemoryCache.set(key: key, image: preparedImage)
                        case .resized(let key): imageMemoryCache.set(key: key, image: preparedImage)
                        }
                    }
                    
                    return preparedImage
                }
            }
        }
        
        // 2. Fetches - initial checks
        if !cachePolicy.fetches {
            throw ImageRepositoryError.imageNotInCache
        }
        
        // 3. Fetches - runs, or joins in-flight work with the same key.
        // Progress clears itself, and is cancelled only when the last waiter is cancelled.
        let image: PlatformImage = try await {
            switch progressCacheStorage {
            case .memory:
                switch progressMemoryCacheKey {
                case .original(let key):
                    try await imageProgressMemoryCache.run(
                        key: key,
                        operation: { try await fetchImage(parameter) }
                    )
                    
                case .resized(let key):
                    try await imageProgressMemoryCache.run(
                        key: key,
                        operation: { try await fetchImage(parameter) }
                    )
                }
                
            case nil:
                try await fetchImage(parameter)
            }
        }()
        try Task.checkCancellation()
        
        // 4. Fetches - saves image
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
                    Logger.default.warning("Misuse of 'DefaultImageRepository'. Raw 'UIImage' has no stable disk identity. Writing to disk is a no-op, as the key won't survive relaunch.")
#elseif canImport(AppKit)
                    Logger.default.warning("Misuse of 'DefaultImageRepository'. Raw 'NSImage' has no stable disk identity. Writing to disk is a no-op, as the key won't survive relaunch.")
#endif
                }
                
                // Encoding and writing run in the background, so the image is returned without waiting for them.
                // Task is detached, so a cancelled caller doesn't abandon a fetch that has already completed.
                Task.detached(priority: .utility) { [imageDiskCache] in
                    switch diskCacheKey {
                    case .original(let key): imageDiskCache.set(key: key, image: image)
                    case .resized(let key): imageDiskCache.set(key: key, image: image)
                    }
                }
            }
        }
        
        // 5. Result
        return image
    }
    
    // MARK: Helpers
    @concurrent
    private func fetchImage(
        parameter: ImageRepositoryParameter
    ) async throws -> PlatformImage {
        let image: PlatformImage = try await {
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
                
#if !os(watchOS)
            case .photo_Asset(let asset):
                try await imageFetchWorker.fetchPhotoImage(asset: asset)
#endif
                
#if !os(tvOS) && !os(watchOS)
            case .photo_Item(let item):
                try await imageFetchWorker.fetchPhotoImage(item: item)
#endif
                
#if !os(watchOS)
            case .photo_AssetIdentifier(let assetIdentifier):
                try await imageFetchWorker.fetchPhotoImage(assetIdentifier: assetIdentifier)
#endif
            }
        }()
        try Task.checkCancellation()
        
        guard
            preparesForDisplay(parameter: parameter)
        else {
            return image
        }
        
        let preparedImage: PlatformImage = await prepareForDisplay(image: image)
        try Task.checkCancellation()
        
        return preparedImage
    }

    // Images passed as-is, or managed by the platform, such as assets, are left untouched.
    // Rasterizing them would discard vector data and symbol configurations.
    private func preparesForDisplay(
        parameter: ImageRepositoryParameter
    ) -> Bool {
        switch parameter.storage {
        case .image: false
        case .data: true
        case .asset: false
        case .local: true
        case .remote: true
#if !os(watchOS)
        case .photo_Asset: true
#endif
#if !os(tvOS) && !os(watchOS)
        case .photo_Item: true
#endif
#if !os(watchOS)
        case .photo_AssetIdentifier: true
#endif
        }
    }
    
    // Decodes bitmap ahead of the first draw. Falls back to the image itself, if it can't be prepared.
    @concurrent
    private func prepareForDisplay(
        image: PlatformImage
    ) async -> PlatformImage {
#if canImport(UIKit)

#if os(watchOS)

        let preparedImage: PlatformImage? = image.byPreparingForDisplayWatchOS()

#else

        let preparedImage: PlatformImage? = await image.byPreparingForDisplay()

#endif

#elseif canImport(AppKit)

        let preparedImage: PlatformImage? = image.byPreparingForDisplay()

#endif

        return preparedImage ?? image
    }

    @concurrent
    private func makeThumbnail(
        image: PlatformImage,
        size: CGSize
    ) async throws -> PlatformImage {
#if canImport(UIKit)
        
#if os(watchOS)
        
        guard
            let thumbnail: PlatformImage = image.byPreparingThumbnailWatchOS(ofSize: size)
        else {
            throw ImageRepositoryError.failedToResizeImage
        }
        
#else
        
        guard
            let thumbnail: PlatformImage = await image.byPreparingThumbnail(ofSize: size)
        else {
            throw ImageRepositoryError.failedToResizeImage
        }
        try Task.checkCancellation()
        
#endif
        
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
    nonisolated private enum Key<Original, Resized>: Sendable
        where
            Original: Sendable,
            Resized: Sendable
    {
        case original(Original)
        case resized(Resized)
    }
}
