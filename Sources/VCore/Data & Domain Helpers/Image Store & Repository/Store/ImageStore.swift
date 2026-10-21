//
//  ImageStore.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

public import SwiftUI
#if canImport(UIKit)
public import UIKit
#elseif canImport(AppKit)
public import AppKit
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

    // MARK: Properties - Eviction
#if canImport(UIKit) && !os(watchOS)
    private var evictionBackgroundTaskID: UIBackgroundTaskIdentifier = .invalid
#endif
    
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

    // MARK: Memory Cache - Platform Image
    /// Returns original image from memory cache, if present.
    ///
    /// Synchronous, so a view can show an already-loaded image in its first frame.
    public func originalImageFromMemoryCache(
        parameter: ImageRepositoryParameter
    ) -> PlatformImage? {
        imageRepository.imageMemoryCache.get(
            key: ImageMemoryCacheOriginalKey(
                parameter: parameter
            )
        )
    }

    /// Returns resized image from memory cache, if present.
    ///
    /// Synchronous, so a view can show an already-loaded image in its first frame.
    public func resizedImageFromMemoryCache(
        parameter: ImageRepositoryParameter,
        size: CGSize
    ) -> PlatformImage? {
        imageRepository.imageMemoryCache.get(
            key: ImageMemoryCacheResizedKey(
                parameter: parameter,
                size: size
            )
        )
    }

    // MARK: Memory Cache - Image
    /// Returns original image from memory cache, if present.
    ///
    /// Synchronous, so a view can show an already-loaded image in its first frame.
    public func originalImageFromMemoryCache(
        parameter: ImageRepositoryParameter
    ) -> Image? {
        guard
            let image: PlatformImage = originalImageFromMemoryCache(
                parameter: parameter
            )
        else {
            return nil
        }

#if canImport(UIKit)
        let image2: Image = .init(uiImage: image)
#elseif canImport(AppKit)
        let image2: Image = .init(nsImage: image)
#endif

        return image2
    }

    /// Returns resized image from memory cache, if present.
    ///
    /// Synchronous, so a view can show an already-loaded image in its first frame.
    public func resizedImageFromMemoryCache(
        parameter: ImageRepositoryParameter,
        size: CGSize
    ) -> Image? {
        guard
            let image: PlatformImage = resizedImageFromMemoryCache(
                parameter: parameter,
                size: size
            )
        else {
            return nil
        }

#if canImport(UIKit)
        let image2: Image = .init(uiImage: image)
#elseif canImport(AppKit)
        let image2: Image = .init(nsImage: image)
#endif

        return image2
    }

    // MARK: Copy
    /// Copies original image and all of its resized images in cache from one parameter to another.
    ///
    /// Lets an image already loaded for one parameter serve another one immediately,
    /// such as a local attachment that becomes remote once uploaded.
    public func copyImagesInCache(
        sourceParameter: ImageRepositoryParameter,
        destinationParameter: ImageRepositoryParameter
    ) {
        imageRepository.imageMemoryCache.copy(
            sourceParameter: sourceParameter,
            destinationParameter: destinationParameter
        )

        imageRepository.imageDiskCache.copy(
            sourceParameter: sourceParameter,
            destinationParameter: destinationParameter
        )
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
        
        imageRepository.imageProgressMemoryCache.cancel(
            key: ImageProgressMemoryCacheOriginalKey(
                parameter: parameter
            )
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
        
        imageRepository.imageProgressMemoryCache.cancel(
            key: ImageProgressMemoryCacheResizedKey(
                parameter: parameter,
                size: size
            ),
            cancelAllSizes: deleteAllSizes
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
            imageRepository.imageProgressMemoryCache.cancelAll(
                type: imageProgressMemoryCacheType
            )
        }
    }
    
    // MARK: Eviction
    // Eviction enumerates and deletes files, so it runs in the background instead of on the main actor
    private func evictDiskCache() {
#if canImport(UIKit) && !os(watchOS)

        guard evictionBackgroundTaskID == .invalid else { return } // Eviction is already in progress

        // Keeps the app alive until eviction finishes, as it starts right as the app is about to be suspended
        evictionBackgroundTaskID = UIApplication.shared.beginBackgroundTask(
            expirationHandler: { [weak self] in self?.endEvictionBackgroundTask() }
        )

        Task.detached(priority: .utility) { [self] in
            imageRepository.imageDiskCache.evictIfNeeded()
            await endEvictionBackgroundTask()
        }

#else

        Task.detached(priority: .utility) { [self] in
            imageRepository.imageDiskCache.evictIfNeeded()
        }

#endif
    }

#if canImport(UIKit) && !os(watchOS)
    private func endEvictionBackgroundTask() {
        guard evictionBackgroundTaskID != .invalid else { return }

        UIApplication.shared.endBackgroundTask(evictionBackgroundTaskID)
        evictionBackgroundTaskID = .invalid
    }
#endif
    
    // MARK: Subscriptions
    private func addSubscriptions() {
#if canImport(UIKit)
        
#if os(watchOS)
        
        NotificationCenter.default
            .publisher(for: WKApplication.didEnterBackgroundNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.evictDiskCache() }
            .store(in: &cancellables)
        
#else
        
        NotificationCenter.default
            .publisher(for: UIApplication.didEnterBackgroundNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.evictDiskCache() }
            .store(in: &cancellables)
        
#endif
        
#elseif canImport(AppKit)
        
        NotificationCenter.default
            .publisher(for: NSApplication.didResignActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.evictDiskCache() }
            .store(in: &cancellables)
        
#endif
    }
}
