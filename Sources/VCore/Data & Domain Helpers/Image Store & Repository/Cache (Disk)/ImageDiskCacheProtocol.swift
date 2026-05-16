//
//  ImageDiskCacheProtocol.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import Foundation

/// Image disk cache protocol.
nonisolated public protocol ImageDiskCacheProtocol: Actor {
    // MARK: Operation - Get
    /// Gets original image.
    func get(
        key: ImageDiskCache_OriginalKey
    ) -> PlatformImage?
    
    /// Gets resized image.
    func get(
        key: ImageDiskCache_ResizedKey
    ) -> PlatformImage?
    
    // MARK: Operation - Set
    /// Sets original image.
    func set(
        key: ImageDiskCache_OriginalKey,
        image: PlatformImage
    )
    
    /// Sets resized image.
    func set(
        key: ImageDiskCache_ResizedKey,
        image: PlatformImage
    )

    // MARK: Operation - Delete
    /// Deletes original image.
    func delete(
        key: ImageDiskCache_OriginalKey
    )
    
    /// Deletes resized image.
    func delete(
        key: ImageDiskCache_ResizedKey
    )
    
    // MARK: Operation - Delete All
    /// Deletes all images.
    func deleteAll(
        type: ImageDiskCache_CacheType
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
@OptionSetRepresentation<Int>
nonisolated public struct ImageDiskCache_CacheType: Sendable {
    private enum Options: Int {
        case original
        case resized
    }
}

/// Original key.
nonisolated public struct ImageDiskCache_OriginalKey: Sendable {
    // MARK: Properties
    /// Image parameter.
    public let parameter: ImageRepository_Parameter

    // MARK: Initializers
    /// Initializes `ImageDiskCache_OriginalKey`.
    public init(
        parameter: ImageRepository_Parameter
    ) {
        self.parameter = parameter
    }
}

/// Resized key.
nonisolated public struct ImageDiskCache_ResizedKey: Sendable {
    // MARK: Properties
    /// Image parameter.
    public let parameter: ImageRepository_Parameter
    
    /// Image width.
    public let width: Int
    
    /// Image height.
    public let height: Int

    // MARK: Initializers
    /// Initializes `ImageDiskCache_ResizedKey`.
    public init(
        parameter: ImageRepository_Parameter,
        size: CGSize
    ) {
        let quantizedSize: CGSize = size.quantized()
        
        self.parameter = parameter
        self.width = Int(quantizedSize.width)
        self.height = Int(quantizedSize.height)
    }
    
    /// Initializes `ImageDiskCache_ResizedKey`.
    public init(
        parameter: ImageRepository_Parameter,
        width: CGFloat,
        height: CGFloat
    ) {
        self.init(
            parameter: parameter,
            size: CGSize(width: width, height: height)
        )
    }
}
