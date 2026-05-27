//
//  MockImageRepositoryFetchWorker.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if DEBUG

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
import Photos
import PhotosUI

/// Mock worker that fetches images for `ImageRepository`.
nonisolated public final class MockImageRepositoryFetchWorker: DefaultImageRepositoryFetchWorker, @unchecked Sendable {
    // MARK: Properties - Images
    private let image: PlatformImage? = .init(
        size: CGSize(dimension: 500),
        color: PlatformColor.systemBlue
    )
    
    // MARK: Initializers
    /// Initializes `MockImageRepositoryFetchWorker`.
    override public init() {}
    
    // MARK: Operations
    override public func fetchRemoteImage(
        url: URL
    ) async throws -> PlatformImage {
        try fetchImage()
    }
    
    override public func fetchPhotoImage(
        asset: PHAsset
    ) async throws -> PlatformImage {
        try fetchImage()
    }
    
    override public func fetchPhotoImage(
        item: PhotosPickerItem
    ) async throws -> PlatformImage {
        try fetchImage()
    }
    
    override public func fetchPhotoImage(
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
