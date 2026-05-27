//
//  ImageStore.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
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
///         var imageRepository: Factory<any ImageRepository> {
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
///                 return DefaultImageRepository(
///                     imageFetchWorker: DefaultImageRepositoryFetchWorker(),
///                     imageMemoryCache: DefaultImageMemoryCache(),
///                     imageDiskCache: DefaultImageDiskCache(),
///                     imageProgressMemoryCache: DefaultImageProgressMemoryCache()
///                 )
///             }
///             .singleton
///         }
///     }
///
public final class ImageStore {
    // MARK: Properties - Dependencies
    /// Image repository.
    public let imageRepository: any ImageRepository
    
    // MARK: Properties - Subscriptions
    private var cancellables: Set<AnyCancellable> = []

    // MARK: Initializers
    /// Initializes `ImageStore`.
    public init(
        imageRepository: any ImageRepository
    ) {
        self.imageRepository = imageRepository
        
        addSubscriptions()
    }
    
    // MARK: Fetch - Platform Image
    /// Fetches original image.
    public func fetchOriginalImage(
        parameter: ImageRepositoryParameter,
        cachePolicy: ImageRepositoryCachePolicy = .default,
        cacheStorage: ImageRepositoryCacheStorage = .default,
        progressCacheStorage: ImageRepositoryProgressCacheStorage? = .default
    ) async throws -> PlatformImage {
        try await imageRepository.fetchOriginalImage(
            parameter: parameter,
            cachePolicy: cachePolicy,
            cacheStorage: cacheStorage,
            progressCacheStorage: progressCacheStorage
        )
    }
    
    /// Fetches resized image.
    public func fetchResizedImage(
        parameter: ImageRepositoryParameter,
        size: CGSize,
        cachePolicy: ImageRepositoryCachePolicy = .default,
        cacheStorage: ImageRepositoryCacheStorage = .default,
        progressCacheStorage: ImageRepositoryProgressCacheStorage? = .default,
        imageVariantCachingPolicy: ImageRepositoryResizedImageVariantCachingPolicy = .default
    ) async throws -> PlatformImage {
        try await imageRepository.fetchResizedImage(
            parameter: parameter,
            size: size,
            cachePolicy: cachePolicy,
            cacheStorage: cacheStorage,
            progressCacheStorage: progressCacheStorage,
            imageVariantCachingPolicy: imageVariantCachingPolicy
        )
    }
    
    // MARK: Fetch - Image
    /// Fetches original image.
    public func fetchOriginalImage(
        parameter: ImageRepositoryParameter,
        cachePolicy: ImageRepositoryCachePolicy = .default,
        cacheStorage: ImageRepositoryCacheStorage = .default,
        progressCacheStorage: ImageRepositoryProgressCacheStorage? = .default
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
        parameter: ImageRepositoryParameter,
        size: CGSize,
        cachePolicy: ImageRepositoryCachePolicy = .default,
        cacheStorage: ImageRepositoryCacheStorage = .default,
        progressCacheStorage: ImageRepositoryProgressCacheStorage? = .default,
        imageVariantCachingPolicy: ImageRepositoryResizedImageVariantCachingPolicy = .default
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
        parameter: ImageRepositoryParameter
    ) {
        imageRepository.imageMemoryCache.delete(
            key: ImageMemoryCacheOriginalKey(
                parameter: parameter
            )
        )
        
        imageRepository.imageDiskCache.delete(
            key: ImageDiskCacheOriginalKey(
                parameter: parameter
            )
        )
        
        imageRepository.imageProgressMemoryCache.delete(
            key: ImageProgressMemoryCacheOriginalKey(
                parameter: parameter
            ),
            cancel: true
        )
    }
    
    /// Deletes resized image from cache.
    public func deleteResizedImageFromCache(
        parameter: ImageRepositoryParameter,
        size: CGSize,
        deleteAllSizes: Bool = true
    ) {
        imageRepository.imageMemoryCache.delete(
            key: ImageMemoryCacheResizedKey(
                parameter: parameter,
                size: size
            ),
            deleteAllSizes: deleteAllSizes
        )
        
        imageRepository.imageDiskCache.delete(
            key: ImageDiskCacheResizedKey(
                parameter: parameter,
                size: size
            ),
            deleteAllSizes: deleteAllSizes
        )
        
        imageRepository.imageProgressMemoryCache.delete(
            key: ImageProgressMemoryCacheResizedKey(
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
        imageMemoryCacheType: ImageMemoryCacheCacheType?,
        imageDiskCacheType: ImageDiskCacheCacheType?,
        imageProgressMemoryCacheType: ImageProgressMemoryCacheCacheType?
    ) {
        if let imageMemoryCacheType {
            imageRepository.imageMemoryCache.deleteAll(
                type: imageMemoryCacheType
            )
        }
        
        if let imageDiskCacheType {
            imageRepository.imageDiskCache.deleteAll(
                type: imageDiskCacheType
            )
        }
        
        if let imageProgressMemoryCacheType {
            imageRepository.imageProgressMemoryCache.deleteAll(
                type: imageProgressMemoryCacheType,
                cancel: true
            )
        }
    }
    
    // MARK: Subscriptions
    private func addSubscriptions() {
#if canImport(UIKit)

        NotificationCenter.default
            .publisher(for: UIApplication.didEnterBackgroundNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.imageRepository.imageDiskCache.evictIfNeeded() }
            .store(in: &cancellables)
        
#elseif canImport(AppKit)

        NotificationCenter.default
            .publisher(for: NSApplication.didResignActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.imageRepository.imageDiskCache.evictIfNeeded() }
            .store(in: &cancellables)
        
#endif
    }
}
