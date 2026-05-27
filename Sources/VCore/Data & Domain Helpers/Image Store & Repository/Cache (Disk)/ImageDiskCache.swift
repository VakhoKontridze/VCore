//
//  ImageDiskCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if canImport(UIKit)
public import UIKit
#elseif canImport(AppKit)
public import AppKit
#endif

/// Image disk cache.
nonisolated public protocol ImageDiskCache: AnyObject, Sendable {
    // MARK: Operation - Get
    /// Gets original image.
    func get(
        key: ImageDiskCacheOriginalKey
    ) -> PlatformImage?
    
    /// Gets resized image.
    func get(
        key: ImageDiskCacheResizedKey
    ) -> PlatformImage?
    
    // MARK: Operation - Set
    /// Sets original image.
    func set(
        key: ImageDiskCacheOriginalKey,
        image: PlatformImage
    )
    
    /// Sets resized image.
    func set(
        key: ImageDiskCacheResizedKey,
        image: PlatformImage
    )

    // MARK: Operation - Delete
    /// Deletes original image.
    func delete(
        key: ImageDiskCacheOriginalKey
    )
    
    /// Deletes resized image.
    func delete(
        key: ImageDiskCacheResizedKey,
        deleteAllSizes: Bool
    )
    
    // MARK: Operation - Delete All
    /// Deletes all images.
    func deleteAll(
        type: ImageDiskCacheCacheType
    )
    
    // MARK: Operation - Evict
    /// Removes image that exceed `maxAge` or, if total size exceeds `maxBytes`.
    /// Evicts least-recently-used image until within budget.
    ///
    /// Drive this from `UIApplication.didEnterBackgroundNotification`,
    /// so eviction runs while the user is not looking at images.
    func evictIfNeeded()
}

/// Image cache type.
@OptionSetRepresentation
nonisolated public struct ImageDiskCacheCacheType: Sendable {
    private enum Options: Int {
        case original
        case resized
    }
}

/// Original key.
nonisolated public struct ImageDiskCacheOriginalKey: Sendable {
    // MARK: Properties
    /// Image parameter.
    public let parameter: ImageRepositoryParameter

    // MARK: Initializers
    /// Initializes `ImageDiskCacheOriginalKey`.
    public init(
        parameter: ImageRepositoryParameter
    ) {
        self.parameter = parameter
    }
}

/// Resized key.
nonisolated public struct ImageDiskCacheResizedKey: Sendable {
    // MARK: Properties
    /// Image parameter.
    public let parameter: ImageRepositoryParameter
    
    /// Image width.
    public let width: Int
    
    /// Image height.
    public let height: Int

    // MARK: Initializers
    /// Initializes `ImageDiskCacheResizedKey`.
    public init(
        parameter: ImageRepositoryParameter,
        size: CGSize
    ) {
        let quantizedSize: CGSize = size.quantized()
        
        self.parameter = parameter
        self.width = Int(quantizedSize.width)
        self.height = Int(quantizedSize.height)
    }
    
    /// Initializes `ImageDiskCacheResizedKey`.
    public init(
        parameter: ImageRepositoryParameter,
        width: CGFloat,
        height: CGFloat
    ) {
        self.init(
            parameter: parameter,
            size: CGSize(width: width, height: height)
        )
    }
}
