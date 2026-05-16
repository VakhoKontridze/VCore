//
//  MockImageRepository.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if DEBUG

import Foundation

/// Mock image repository.
nonisolated public final class MockImageRepository: ImageRepositoryProtocol {
    // MARK: Properties - Dependencies
    public let imageFetchWorker: any ImageRepositoryFetchWorkerProtocol
    
    public let imageMemoryCache: any ImageMemoryCacheProtocol
    public let imageDiskCache: any ImageDiskCacheProtocol
    
    public let imageProgressMemoryCache: any ImageProgressMemoryCacheProtocol
    
    // MARK: Properties - Images
    private let image: PlatformImage? = .init(
        size: CGSize(dimension: 1_000),
        color: PlatformColor.systemBlue
    )
    
    // MARK: Initializers
    /// Initializes `MockImageRepository`.
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
        guard
            let image
        else {
            throw ImageRepositoryError.failedToCreateImage
        }
        
        return image
    }
    
    public func fetchResizedImage(
        parameter: ImageRepository_Parameter,
        size: CGSize,
        cachePolicy: ImageRepository_CachePolicy,
        cacheStorage: ImageRepository_CacheStorage,
        progressCacheStorage: ImageRepository_ProgressCacheStorage?,
        imageVariantCachingPolicy: ImageRepository_ResizedImageVariantCachingPolicy
    ) async throws -> PlatformImage {
        guard
            let image: PlatformImage = .init(
                size: size,
                color: PlatformColor.systemBlue
            )
        else {
            throw ImageRepositoryError.failedToCreateImage
        }
        
        return image
    }
}

#endif
