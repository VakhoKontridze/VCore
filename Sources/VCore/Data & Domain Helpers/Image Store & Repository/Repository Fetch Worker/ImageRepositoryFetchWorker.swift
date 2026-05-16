//
//  ImageRepositoryFetchWorker.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import SwiftUI
import Photos
import PhotosUI

/// Worker that fetches images for `ImageRepository`.
nonisolated open class ImageRepositoryFetchWorker: ImageRepositoryFetchWorkerProtocol, @unchecked Sendable {
    // MARK: Initializers
    /// Initializes `ImageRepositoryFetchWorker`.
    public init() {}
    
    // MARK: Operations
    public func fetchImage(
        image: PlatformImage
    ) async throws -> PlatformImage {
        image
    }
    
    public func fetchImage(
        data: Data
    ) async throws -> PlatformImage {
        try await makeImage(
            data: data
        )
    }
    
    public func fetchAssetImage(
        name: String,
        bundle: Bundle?
    ) async throws -> PlatformImage {
        guard
            let image: PlatformImage = .init(named: name, in: bundle, with: nil)
        else {
            throw ImageRepositoryError.failedToCreateImage
        }
        
        return image
    }
    
    public func fetchLocalImage(
        url: URL
    ) async throws -> PlatformImage {
        guard
            let image: PlatformImage = .init(contentsOfFile: url.path())
        else {
            throw URLError(.cannotDecodeContentData)
        }
        
        return image
    }
    
    public func fetchRemoteImage(
        url: URL
    ) async throws -> PlatformImage {
        let data: Data = try await URLSession.shared.data(from: url).0
        try Task.checkCancellation()

        let image: PlatformImage = try await makeImage(data: data)
        try Task.checkCancellation()

        return image
    }
    
    public func fetchPhotoImage(
        asset: PHAsset
    ) async throws -> PlatformImage {
        try await withCheckedThrowingContinuation { continuation in
            let options: PHImageRequestOptions = .init()
            options.isNetworkAccessAllowed = true
            options.deliveryMode = .highQualityFormat
            options.resizeMode = .none
            options.isSynchronous = false
            
            PHImageManager.default().requestImageDataAndOrientation(
                for: asset,
                options: options
            ) { (data, _, _, info) in
                if
                    let isDegraded = info?[PHImageResultIsDegradedKey] as? Bool,
                    isDegraded
                {
                    return
                }
                
                if
                    let error = info?[PHImageErrorKey] as? Error
                {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard
                    let data,
                    let image: PlatformImage = .init(data: data)
                else {
                    continuation.resume(throwing: URLError(.cannotDecodeContentData))
                    return
                }
                
                continuation.resume(returning: image)
            }
        }
    }
    
    public func fetchPhotoImage(
        item: PhotosPickerItem
    ) async throws -> PlatformImage {
        guard
            let data: Data = try await item.loadTransferable(type: Data.self)
        else {
            throw ImageRepositoryError.failedToCreateImage
        }
        try Task.checkCancellation()
        
        let image: PlatformImage = try await makeImage(data: data)
        try Task.checkCancellation()
        
        return image
    }
    
    public func fetchPhotoImage(
        assetIdentifier: String
    ) async throws -> PlatformImage {
        let result: PHFetchResult<PHAsset> = PHAsset.fetchAssets(
            withLocalIdentifiers: [assetIdentifier],
            options: nil
        )
        
        guard
            let asset: PHAsset = result.firstObject
        else {
            throw URLError(.fileDoesNotExist)
        }
        
        return try await fetchPhotoImage(asset: asset)
    }
    
    // MARK: Helpers
    @concurrent
    private func makeImage(
        data: Data
    ) async throws -> PlatformImage {
        guard
            let image: PlatformImage = .init(data: data)
        else {
            throw ImageRepositoryError.failedToCreateImage
        }
        
        return image
    }
}
