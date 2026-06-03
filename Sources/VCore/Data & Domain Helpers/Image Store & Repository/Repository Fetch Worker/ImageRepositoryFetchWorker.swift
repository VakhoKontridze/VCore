//
//  ImageRepositoryFetchWorker.swift
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
#if !os(watchOS)
public import Photos
#endif
#if !os(tvOS)
public import PhotosUI
#endif

/// Worker that fetches images for `ImageRepository`.
public protocol ImageRepositoryFetchWorker: AnyObject, Sendable {
    /// Fetches image.
    func fetchImage(
        image: PlatformImage
    ) async throws -> PlatformImage
    
    /// Fetches image from data.
    func fetchImage(
        data: Data
    ) async throws -> PlatformImage
    
    /// Fetches image from the `Bundle`.
    func fetchAssetImage(
        name: String,
        bundle: Bundle?
    ) async throws -> PlatformImage
    
    /// Fetches image from local storage.
    func fetchLocalImage(
        url: URL
    ) async throws -> PlatformImage
    
    /// Fetches image from network.
    func fetchRemoteImage(
        url: URL
    ) async throws -> PlatformImage
    
#if !os(watchOS)
    /// Fetches image from `Photos` asset.
    func fetchPhotoImage(
        asset: PHAsset
    ) async throws -> PlatformImage
#endif
    
#if !os(tvOS)
    /// Fetches image from `Photos` item.
    func fetchPhotoImage(
        item: PhotosPickerItem
    ) async throws -> PlatformImage
#endif
    
#if !os(watchOS)
    /// Fetches image from `Photos` asset identifier.
    func fetchPhotoImage(
        assetIdentifier: String
    ) async throws -> PlatformImage
#endif
}
