//
//  MockImageRepository.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if DEBUG

#if canImport(UIKit)
public import UIKit
#elseif canImport(AppKit)
public import AppKit
#endif

/// Mock image repository.
nonisolated open class MockImageRepository: ImageRepository, @unchecked Sendable {
    // MARK: Properties - Dependencies
    public let imageFetchWorker: any ImageRepositoryFetchWorker
    
    public let imageMemoryCache: any ImageMemoryCache
    public let imageDiskCache: any ImageDiskCache
    
    public let imageProgressMemoryCache: any ImageProgressMemoryCache
    
    // MARK: Initializers
    /// Initializes `MockImageRepository`.
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
    open func fetchOriginalImage(
        parameter: ImageRepositoryParameter,
        cachePolicy: ImageRepositoryCachePolicy,
        cacheStorage: ImageRepositoryCacheStorage,
        progressCacheStorage: ImageRepositoryProgressCacheStorage?
    ) async throws -> PlatformImage {
        try await fetchImage(parameter: parameter)
    }
    
    open func fetchResizedImage(
        parameter: ImageRepositoryParameter,
        size: CGSize,
        cachePolicy: ImageRepositoryCachePolicy,
        cacheStorage: ImageRepositoryCacheStorage,
        progressCacheStorage: ImageRepositoryProgressCacheStorage?,
        imageVariantCachingPolicy: ImageRepositoryResizedImageVariantCachingPolicy
    ) async throws -> PlatformImage {
        try await fetchImage(parameter: parameter)
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
}

#endif
