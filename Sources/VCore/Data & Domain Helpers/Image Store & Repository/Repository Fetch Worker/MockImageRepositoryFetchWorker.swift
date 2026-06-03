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
#if !os(watchOS)
public import Photos
#endif
#if !os(tvOS)
public import PhotosUI
#endif

/// Mock worker that fetches images for `ImageRepository`.
nonisolated open class MockImageRepositoryFetchWorker: DefaultImageRepositoryFetchWorker, @unchecked Sendable {
    // MARK: Properties - Images
    private let image: PlatformImage? = .init(
        size: CGSize(dimension: 500),
        color: {
#if os(watchOS)
                UIColor.blue
#else
                PlatformColor.systemBlue
#endif
            }()
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
    
#if !os(watchOS)
    override open func fetchPhotoImage(
        asset: PHAsset
    ) async throws -> PlatformImage {
        try fetchImage()
    }
#endif
    
#if !os(tvOS)
    override open func fetchPhotoImage(
        item: PhotosPickerItem
    ) async throws -> PlatformImage {
        try fetchImage()
    }
#endif
    
#if !os(watchOS)
    override open func fetchPhotoImage(
        assetIdentifier: String
    ) async throws -> PlatformImage {
        try fetchImage()
    }
#endif
    
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
