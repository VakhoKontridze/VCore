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
    @concurrent
    public func fetchOriginalImage(
        parameter: ImageRepository_Parameter,
        cachePolicy: ImageRepository_CachePolicy,
        cacheStorage: ImageRepository_CacheStorage,
        progressCacheStorage: ImageRepository_ProgressCacheStorage?
    ) async throws -> PlatformImage {
        try await fetchImage(parameter: parameter)
    }
    
    @concurrent
    public func fetchResizedImage(
        parameter: ImageRepository_Parameter,
        size: CGSize,
        cachePolicy: ImageRepository_CachePolicy,
        cacheStorage: ImageRepository_CacheStorage,
        progressCacheStorage: ImageRepository_ProgressCacheStorage?,
        imageVariantCachingPolicy: ImageRepository_ResizedImageVariantCachingPolicy
    ) async throws -> PlatformImage {
        try await fetchImage(parameter: parameter)
    }
    
    // MARK: Helpers
    @concurrent
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
}

#endif
