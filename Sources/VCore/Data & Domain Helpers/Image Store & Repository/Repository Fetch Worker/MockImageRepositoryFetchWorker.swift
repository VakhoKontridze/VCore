//
//  MockImageRepositoryFetchWorker.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if DEBUG

import SwiftUI
import Photos
import PhotosUI

/// Mock worker that fetches images for `ImageRepository`.
nonisolated public final class MockImageRepositoryFetchWorker: ImageRepositoryFetchWorker, @unchecked Sendable {
    // MARK: Properties - Images
    private let image: PlatformImage? = .init(
        size: CGSize(dimension: 1_000),
        color: PlatformColor.systemBlue
    )
    
    // MARK: Initializers
    /// Initializes `MockImageRepositoryFetchWorker`.
    public override init() {}
    
    // MARK: Operations
    public override func fetchRemoteImage(
        url: URL
    ) async throws -> PlatformImage {
        try fetchImage()
    }
    
    public override func fetchPhotoImage(
        asset: PHAsset
    ) async throws -> PlatformImage {
        try fetchImage()
    }
    
    public override func fetchPhotoImage(
        item: PhotosPickerItem
    ) async throws -> PlatformImage {
        try fetchImage()
    }
    
    public override func fetchPhotoImage(
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
