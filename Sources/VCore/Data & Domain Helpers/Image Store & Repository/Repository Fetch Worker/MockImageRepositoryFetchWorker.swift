//
//  MockImageRepositoryFetchWorker.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if DEBUG

public import SwiftUI
#if canImport(UIKit)
public import UIKit
#elseif canImport(AppKit)
public import AppKit
#endif
public import Photos
public import PhotosUI

/// Mock worker that fetches images for `ImageRepository`.
nonisolated open class MockImageRepositoryFetchWorker: DefaultImageRepositoryFetchWorker, @unchecked Sendable {
    // MARK: Properties - Images
    private let image: PlatformImage? = .init(
        size: CGSize(dimension: 500),
        color: PlatformColor.systemBlue
    )
    
    // MARK: Initializers
    /// Initializes `MockImageRepositoryFetchWorker`.
    override public init() {}
    
    // MARK: Operations
    override open func fetchRemoteImage(
        url: URL
    ) async throws -> PlatformImage {
        try fetchImage()
    }
    
    override open func fetchPhotoImage(
        asset: PHAsset
    ) async throws -> PlatformImage {
        try fetchImage()
    }
    
    override open func fetchPhotoImage(
        item: PhotosPickerItem
    ) async throws -> PlatformImage {
        try fetchImage()
    }
    
    override open func fetchPhotoImage(
        assetIdentifier: String
    ) async throws -> PlatformImage {
        try fetchImage()
    }
    
    // MARK: Helpers
    private func fetchImage() throws -> PlatformImage {
        guard
            let image
        else {
            throw ImageRepositoryError.failedToCreateImage
        }
        
        return image
    }
}

#endif
