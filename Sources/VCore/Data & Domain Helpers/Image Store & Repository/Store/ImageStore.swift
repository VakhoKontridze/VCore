//
//  ImageStore.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import SwiftUI
import Combine

/// Image store.
///
///     extension DIContainer {
///         var imageStore: Factory<ImageStore> {
///             self {
///                 ImageStore(
///                     imageRepository: self.imageRepository.resolve()
///                 )
///             }
///             .cached
///         }
///
///         var imageRepository: Factory<any ImageRepositoryProtocol> {
///             self {
///     #if DEBUG
///                 if ProcessInfo.processInfo.isPreview {
///                     return MockImageRepository(
///                         imageFetchWorker: MockImageRepositoryFetchWorker(),
///                         imageMemoryCache: MockImageMemoryCache(),
///                         imageDiskCache: MockImageDiskCache(),
///                         imageProgressMemoryCache: MockImageProgressMemoryCache()
///                     )
///                 }
///     #endif
///
///                 return ImageRepository(
///                     imageFetchWorker: ImageRepositoryFetchWorker(),
///                     imageMemoryCache: ImageMemoryCache(),
///                     imageDiskCache: ImageDiskCache(),
///                     imageProgressMemoryCache: ImageProgressMemoryCache()
///                 )
///             }
///             .singleton
///         }
///     }
///
public final class ImageStore {
    // MARK: Properties - Dependencies
    /// Image repository.
    public let imageRepository: any ImageRepositoryProtocol
    
    // MARK: Properties - Subscriptions
    private var didEnterBackgroundTask: Task<Void, Never>?
    
    private var cancellables: Set<AnyCancellable> = []

    // MARK: Initializers
    /// Initializes `ImageStore`.
    public init(
        imageRepository: any ImageRepositoryProtocol
    ) {
        self.imageRepository = imageRepository
        
        addSubscriptions()
    }
    
    // MARK: Fetch - Platform Image
    /// Fetches original image.
    public func fetchOriginalImage(
        parameter: ImageRepository_Parameter,
        cachePolicy: ImageRepository_CachePolicy = .default,
        cacheStorage: ImageRepository_CacheStorage = .default,
        progressCacheStorage: ImageRepository_ProgressCacheStorage? = .default
    ) async throws -> PlatformImage {
        let image: PlatformImage = try await imageRepository.fetchOriginalImage(
            parameter: parameter,
            cachePolicy: cachePolicy,
            cacheStorage: cacheStorage,
            progressCacheStorage: progressCacheStorage
        )
        try Task.checkCancellation()
        
        return image
    }
    
    /// Fetches resized image.
    public func fetchResizedImage(
        parameter: ImageRepository_Parameter,
        size: CGSize,
        cachePolicy: ImageRepository_CachePolicy = .default,
        cacheStorage: ImageRepository_CacheStorage = .default,
        progressCacheStorage: ImageRepository_ProgressCacheStorage? = .default,
        imageVariantCachingPolicy: ImageRepository_ResizedImageVariantCachingPolicy = .default
    ) async throws -> PlatformImage {
        let image: PlatformImage = try await imageRepository.fetchResizedImage(
            parameter: parameter,
            size: size,
            cachePolicy: cachePolicy,
            cacheStorage: cacheStorage,
            progressCacheStorage: progressCacheStorage,
            imageVariantCachingPolicy: imageVariantCachingPolicy
        )
        try Task.checkCancellation()
        
        return image
    }
    
    // MARK: Fetch - Image
    /// Fetches original image.
    public func fetchOriginalImage(
        parameter: ImageRepository_Parameter,
        cachePolicy: ImageRepository_CachePolicy = .default,
        cacheStorage: ImageRepository_CacheStorage = .default,
        progressCacheStorage: ImageRepository_ProgressCacheStorage? = .default
    ) async throws -> Image {
        let image: PlatformImage = try await imageRepository.fetchOriginalImage(
            parameter: parameter,
            cachePolicy: cachePolicy,
            cacheStorage: cacheStorage,
            progressCacheStorage: progressCacheStorage
        )
        try Task.checkCancellation()
        
#if canImport(UIKit)
        let image2: Image = .init(uiImage: image)
#elseif canImport(AppKit)
        let image2: Image = .init(nsImage: image)
#endif
        
        return image2
    }
    
    /// Fetches resized image.
    public func fetchResizedImage(
        parameter: ImageRepository_Parameter,
        size: CGSize,
        cachePolicy: ImageRepository_CachePolicy = .default,
        cacheStorage: ImageRepository_CacheStorage = .default,
        progressCacheStorage: ImageRepository_ProgressCacheStorage? = .default,
        imageVariantCachingPolicy: ImageRepository_ResizedImageVariantCachingPolicy = .default
    ) async throws -> Image {
        let image: PlatformImage = try await imageRepository.fetchResizedImage(
            parameter: parameter,
            size: size,
            cachePolicy: cachePolicy,
            cacheStorage: cacheStorage,
            progressCacheStorage: progressCacheStorage,
            imageVariantCachingPolicy: imageVariantCachingPolicy
        )
        try Task.checkCancellation()
        
#if canImport(UIKit)
        let image2: Image = .init(uiImage: image)
#elseif canImport(AppKit)
        let image2: Image = .init(nsImage: image)
#endif
        
        return image2
    }
    
    // MARK: Delete
    /// Deletes original image from cache.
    public func deleteOriginalImageFromCache(
        parameter: ImageRepository_Parameter
    ) async {
        await imageRepository.imageMemoryCache.delete(
            key: ImageMemoryCache_OriginalKey(
                parameter: parameter
            )
        )
        
        await imageRepository.imageDiskCache.delete(
            key: ImageDiskCache_OriginalKey(
                parameter: parameter
            )
        )
        
        await imageRepository.imageProgressMemoryCache.delete(
            key: ImageProgressMemoryCache_OriginalKey(
                parameter: parameter
            ),
            cancel: true
        )
    }
    
    /// Deletes resized image from cache.
    public func deleteResizedImageFromCache(
        parameter: ImageRepository_Parameter,
        size: CGSize,
        deleteAllSizes: Bool = true
    ) async {
        await imageRepository.imageMemoryCache.delete(
            key: ImageMemoryCache_ResizedKey(
                parameter: parameter,
                size: size
            ),
            deleteAllSizes: deleteAllSizes
        )
        
        await imageRepository.imageDiskCache.delete(
            key: ImageDiskCache_ResizedKey(
                parameter: parameter,
                size: size
            ),
            deleteAllSizes: deleteAllSizes
        )
        
        await imageRepository.imageProgressMemoryCache.delete(
            key: ImageProgressMemoryCache_ResizedKey(
                parameter: parameter,
                size: size
            ),
            deleteAllSizes: deleteAllSizes,
            cancel: true
        )
    }
    
    // MARK: Delete All
    /// Deletes all images from cache.
    public func deleteAllImagesFromCache(
        imageMemoryCacheType: ImageMemoryCache_CacheType?,
        imageDiskCacheType: ImageDiskCache_CacheType?,
        imageProgressMemoryCacheType: ImageProgressMemoryCache_CacheType?
    ) async {
        if let imageMemoryCacheType {
            await imageRepository.imageMemoryCache.deleteAll(
                type: imageMemoryCacheType
            )
        }
        
        if let imageDiskCacheType {
            await imageRepository.imageDiskCache.deleteAll(
                type: imageDiskCacheType
            )
        }
        
        if let imageProgressMemoryCacheType {
            await imageRepository.imageProgressMemoryCache.deleteAll(
                type: imageProgressMemoryCacheType,
                cancel: true
            )
        }
    }
    
    // MARK: Subscriptions
    private func addSubscriptions() {
        NotificationCenter.default
            .publisher(for: UIApplication.didEnterBackgroundNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                
                guard didEnterBackgroundTask == nil else { return }
                didEnterBackgroundTask = Task {
                    defer { didEnterBackgroundTask = nil }
                    
                    await imageRepository.imageDiskCache.evictIfNeeded()
                }
            }
            .store(in: &cancellables)
    }
}
