//
//  ImageMemoryCacheProtocol.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import Foundation

/// Image memory cache protocol.
nonisolated public protocol ImageMemoryCacheProtocol: Actor {
    // MARK: Operation - Get
    /// Gets original image.
    func get(
        key: ImageMemoryCache_OriginalKey
    ) -> PlatformImage?
    
    /// Gets resized image.
    func get(
        key: ImageMemoryCache_ResizedKey
    ) -> PlatformImage?
    
    // MARK: Operation - Set
    /// Sets original image.
    func set(
        key: ImageMemoryCache_OriginalKey,
        image: PlatformImage
    )
    
    /// Sets resized image.
    func set(
        key: ImageMemoryCache_ResizedKey,
        image: PlatformImage
    )

    // MARK: Operation - Delete
    /// Deletes original image.
    func delete(
        key: ImageMemoryCache_OriginalKey
    )
    
    /// Deletes resized image.
    func delete(
        key: ImageMemoryCache_ResizedKey,
        deleteAllSizes: Bool
    )
    
    // MARK: Operation - Delete All
    /// Deletes all images.
    func deleteAll(
        type: ImageMemoryCache_CacheType
    )
}

/// Image cache type.
@OptionSetRepresentation<Int>
nonisolated public struct ImageMemoryCache_CacheType: Sendable {
    private enum Options: Int {
        case original
        case resized
    }
}

/// Original key.
nonisolated public final class ImageMemoryCache_OriginalKey: NSObject, Sendable {
    // MARK: Properties
    /// Image parameter.
    public let parameter: ImageRepository_Parameter

    // MARK: Initializers
    /// Initializes `ImageMemoryCache_OriginalKey`.
    public init(
        parameter: ImageRepository_Parameter
    ) {
        self.parameter = parameter
    }

    // MARK: Equality
    override public var hash: Int {
        parameter.hashValue
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? Self else { return false }
        
        return parameter == other.parameter
    }
}

/// Resized key.
nonisolated public final class ImageMemoryCache_ResizedKey: NSObject, Sendable {
    // MARK: Properties
    /// Image parameter.
    public let parameter: ImageRepository_Parameter
    
    /// Image width.
    public let width: CGFloat
    
    /// Image height.
    public let height: CGFloat

    // MARK: Initializers
    /// Initializes `ImageMemoryCache_ResizedKey`.
    public init(
        parameter: ImageRepository_Parameter,
        size: CGSize
    ) {
        let quantizedSize: CGSize = size.quantized()
        
        self.parameter = parameter
        self.width = quantizedSize.width
        self.height = quantizedSize.height
    }
    
    /// Initializes `ImageMemoryCache_ResizedKey`.
    convenience public init(
        parameter: ImageRepository_Parameter,
        width: CGFloat,
        height: CGFloat
    ) {
        self.init(
            parameter: parameter,
            size: CGSize(width: width, height: height)
        )
    }

    // MARK: Equality
    override public var hash: Int {
        var hasher: Hasher = .init()
        hasher.combine(parameter)
        hasher.combine(width)
        hasher.combine(height)
        
        return hasher.finalize()
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? Self else { return false }
        
        return
            parameter == other.parameter &&
            width == other.width &&
            height == other.height
    }
}
