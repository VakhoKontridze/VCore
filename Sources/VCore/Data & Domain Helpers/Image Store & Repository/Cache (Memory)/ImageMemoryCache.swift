//
//  ImageMemoryCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Image memory cache.
nonisolated public protocol ImageMemoryCache: AnyObject, Sendable {
    // MARK: Operation - Get
    /// Gets original image.
    func get(
        key: ImageMemoryCacheOriginalKey
    ) -> PlatformImage?
    
    /// Gets resized image.
    func get(
        key: ImageMemoryCacheResizedKey
    ) -> PlatformImage?
    
    // MARK: Operation - Set
    /// Sets original image.
    func set(
        key: ImageMemoryCacheOriginalKey,
        image: PlatformImage
    )
    
    /// Sets resized image.
    func set(
        key: ImageMemoryCacheResizedKey,
        image: PlatformImage
    )

    // MARK: Operation - Delete
    /// Deletes original image.
    func delete(
        key: ImageMemoryCacheOriginalKey
    )
    
    /// Deletes resized image.
    func delete(
        key: ImageMemoryCacheResizedKey,
        deleteAllSizes: Bool
    )
    
    // MARK: Operation - Delete All
    /// Deletes all images.
    func deleteAll(
        type: ImageMemoryCacheCacheType
    )
}

/// Image cache type.
@OptionSetRepresentation
nonisolated public struct ImageMemoryCacheCacheType: Sendable {
    private enum Options: Int {
        case original
        case resized
    }
}

/// Original key.
nonisolated public final class ImageMemoryCacheOriginalKey: NSObject, Sendable {
    // MARK: Properties
    /// Image parameter.
    public let parameter: ImageRepositoryParameter

    // MARK: Initializers
    /// Initializes `ImageMemoryCacheOriginalKey`.
    public init(
        parameter: ImageRepositoryParameter
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
nonisolated public final class ImageMemoryCacheResizedKey: NSObject, Sendable {
    // MARK: Properties
    /// Image parameter.
    public let parameter: ImageRepositoryParameter
    
    /// Image width.
    public let width: CGFloat
    
    /// Image height.
    public let height: CGFloat

    // MARK: Initializers
    /// Initializes `ImageMemoryCacheResizedKey`.
    public init(
        parameter: ImageRepositoryParameter,
        size: CGSize
    ) {
        let quantizedSize: CGSize = size.quantized()
        
        self.parameter = parameter
        self.width = quantizedSize.width
        self.height = quantizedSize.height
    }
    
    /// Initializes `ImageMemoryCacheResizedKey`.
    public convenience init(
        parameter: ImageRepositoryParameter,
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
