//
//  ImageRepositoryProtocol.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import SwiftUI
import Photos
import PhotosUI
import CryptoKit

/// Image repository protocol.
///
/// `parameter` specifies where image comes from.
/// For instance, `local` or `remote`.
///
/// `size` determines wether image is treated as "original or "resized".
///
/// `cachePolicy` specifies if and how the cache is hit.
/// For instance, `reloadIgnoringCache` or `returnCacheDataDontLoad`.
///
/// `cacheStorage` specifies where image is read from and written to.
/// For instance, `memory`, `disk`, or various combinations.
///
/// `progressCacheStorage` specifies where progress is written to.
/// For instance, `memory`.
///
/// `imageVariantCachingPolicy` specifies what gets cached.
/// For instance, `original`,  `resized`, or various combinations.
nonisolated public protocol ImageRepositoryProtocol: AnyObject, Sendable {
    // MARK: Properties
    /// Image fetch worker.
    var imageFetchWorker: any ImageRepositoryFetchWorkerProtocol { get }
    
    /// Image memory cache.
    var imageMemoryCache: any ImageMemoryCacheProtocol { get }
    
    /// Image disk cache.
    var imageDiskCache: any ImageDiskCacheProtocol { get }
    
    /// Image progress memory cache.
    var imageProgressMemoryCache: any ImageProgressMemoryCacheProtocol { get }
    
    // MARK: Operations
    /// Fetches original image.
    func fetchOriginalImage(
        parameter: ImageRepository_Parameter,
        cachePolicy: ImageRepository_CachePolicy,
        cacheStorage: ImageRepository_CacheStorage,
        progressCacheStorage: ImageRepository_ProgressCacheStorage?
    ) async throws -> PlatformImage
    
    /// Fetches resized image.
    func fetchResizedImage(
        parameter: ImageRepository_Parameter,
        size: CGSize,
        cachePolicy: ImageRepository_CachePolicy,
        cacheStorage: ImageRepository_CacheStorage,
        progressCacheStorage: ImageRepository_ProgressCacheStorage?,
        imageVariantCachingPolicy: ImageRepository_ResizedImageVariantCachingPolicy
    ) async throws -> PlatformImage
}

/// Paremeter.
nonisolated public struct ImageRepository_Parameter: Hashable, Sendable {
    // MARK: Properties
    let storage: Storage
    
    // MARK: Initializers
    private init(
        _ storage: Storage
    ) {
        self.storage = storage
    }
    
    /// Image
    public static func image(
        image: PlatformImage
    ) -> Self {
        .init(
            .image(
                image: image
            )
        )
    }
    
    /// Data.
    public static func data(
        data: Data
    ) -> Self {
        .init(
            .data(
                data: data
            )
        )
    }
    
    /// Asset from `Bundle`.
    public static func asset(
        name: String,
        bundle: Bundle? = nil
    ) -> Self {
        .init(
            .asset(
                name: name,
                bundle: bundle
            )
        )
    }
    
    /// Local image.
    public static func local(
        url: URL
    ) -> Self {
        .init(
            .local(
                url: url
            )
        )
    }
    
    /// Remote image.
    public static func remote(
        url: URL
    ) -> Self {
        .init(
            .remote(
                url: url
            )
        )
    }
    
    /// `Photos` asset.
    public static func photo(
        asset: PHAsset
    ) -> Self {
        .init(
            .photo_Asset(
                asset: asset
            )
        )
    }
    
    /// `Photos` item.
    public static func photo(
        item: PhotosPickerItem
    ) -> Self {
        .init(
            .photo_Item(
                item: item
            )
        )
    }
    
    /// `Photos` asset identifier.
    public static func photo(
        assetIdentifier: String
    ) -> Self {
        .init(
            .photo_AssetIdentifier(
                assetIdentifier: assetIdentifier
            )
        )
    }
    
    // MARK: Properties
    /// Cost of caching image.
    public var cacheCost: Int {
        switch storage {
        case .image(let image):
            return image.cacheCost
        
        case .data(let data):
            // Attempts a cheap header parse to get dimensions without full decode
            if
                let source: CGImageSource = CGImageSourceCreateWithData(data as CFData, nil),
                let props: [CFString: Any] = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [CFString: Any],
                let width: Int = props[kCGImagePropertyPixelWidth] as? Int,
                let height: Int = props[kCGImagePropertyPixelHeight] as? Int
            {
                return
                    width *
                    height *
                    4
            }
            
            return data.count
            
        case .asset:
            // Named assets are bundled resources.
            // They don't have a meaningful byte cost until decoded.
            // And `CGFloat` pixel dimensions aren't available without loading.
            return 0
        
        case .local(let url):
            let resourceValues: URLResourceValues? = try? url.resourceValues(forKeys: [.fileSizeKey])
            let fileSize: Int? = resourceValues?.fileSize
            
            return fileSize ?? 0
        
        case .remote:
            // No way to know
            return 0
        
        case .photo_Asset(let asset):
            return Int(
                CGFloat(asset.pixelWidth) *
                CGFloat(asset.pixelHeight) *
                4
            )
            
        case .photo_Item:
            // No way to know
            return 0
        
        case .photo_AssetIdentifier:
            // No way to know
            return 0
        }
    }
    
    /// A stable, launch-invariant string that uniquely identifies this parameter for use as a disk cache key component.
    ///
    /// Unlike `Hasher`, this value is consistent across app launches and is
    /// safe to use in filenames (before `SHA256` hashing in `ImageDiskCache`).
    public var diskIdentifier: String? {
        switch storage {
        case .image:
            return nil

        case .data(let data):
            // Raw hex, as `ImageDiskCache` will SHA256 this along with everything else.
            let hex: String = data.withUnsafeBytes { bytes -> String in
                var hasher: SHA256 = .init()
                hasher.update(bufferPointer: bytes)
                
                return hasher
                    .finalize()
                    .map { String(format: "%02x", $0) }
                    .joined()
            }
            
            return "data_\(hex)"
            
        case .asset(let name, let bundle):
            let bundleID: String =
                bundle?.bundleIdentifier ??
                Bundle.main.bundleIdentifier ??
                "main"
            
            return "asset_\(bundleID)_\(name)"

        case .local(let url):
            // Absolute path uniquely identifies a local file
            return "local_\(url.path())"

        case .remote(let url):
            // Absolute URL string, with -- scheme, host, path, query -- all included
            return "remote_\(url.absoluteString)"

        case .photo_Asset(let asset):
            return "photo_asset_\(asset.localIdentifier)"
            
        case .photo_Item(let item):
            guard
                let itemIdentifier: String = item.itemIdentifier
            else {
                return nil
            }
            
            return "photo_item_\(itemIdentifier)"

        case .photo_AssetIdentifier(let identifier):
            return "photo_assetid_\(identifier)"
        }
    }
    
    // MARK: Types
    nonisolated enum Storage: Hashable {
        case image(image: PlatformImage)
        case data(data: Data)
        case asset(name: String, bundle: Bundle?)
        case local(url: URL)
        case remote(url: URL)
        case photo_Asset(asset: PHAsset)
        case photo_Item(item: PhotosPickerItem)
        case photo_AssetIdentifier(assetIdentifier: String)
    }
}

/// Cache policy.
nonisolated public enum ImageRepository_CachePolicy: Sendable {
    // MARK: Cases
    /// Reads image from cache, or fetches it.
    case useCache
    
    /// Always fetches image, bypassing the cache.
    case reloadIgnoringCache
    
    /// Always reads image from cache.
    case returnCacheDataDontLoad
    
    // MARK: Properties
    var readsFromCache: Bool {
        switch self {
        case .useCache: true
        case .reloadIgnoringCache: false
        case .returnCacheDataDontLoad: true
        }
    }
    
    var fetches: Bool {
        switch self {
        case .useCache: true
        case .reloadIgnoringCache: true
        case .returnCacheDataDontLoad: false
        }
    }
    
    // MARK: Initializers
    /// Default instance.
    public static var `default`: Self { .useCache }
}

/// Cache storage.
@OptionSetRepresentation<Int>
nonisolated public struct ImageRepository_CacheStorage: Sendable {
    // MARK: Options
    nonisolated private enum Options: Int {
        case memory
        case disk
    }
    
    // MARK: Initializers
    /// Default instance.
    public static var `default`: Self { .memory }
}

/// Progress cache storage.
nonisolated public enum ImageRepository_ProgressCacheStorage: Sendable {
    // MARK: Cases
    /// Memory.
    case memory
    
    // MARK: Initializers
    /// Default instance.
    public static var `default`: Self { .memory }
}

/// Resized image variant caching policy.
@OptionSetRepresentation<Int>
nonisolated public struct ImageRepository_ResizedImageVariantCachingPolicy: Sendable {
    // MARK: Options
    nonisolated private enum Options: Int {
        case original
        case resized
    }
    
    // MARK: Initializers
    /// Default instance.
    public static var `default`: Self { .all }
}
