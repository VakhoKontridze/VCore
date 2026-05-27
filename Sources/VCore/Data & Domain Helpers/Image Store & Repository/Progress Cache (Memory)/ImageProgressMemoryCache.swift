//
//  ImageProgressMemoryCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Image progress memory cache.
nonisolated public protocol ImageProgressMemoryCache: AnyObject, Sendable {
    // MARK: Operation - Get
    /// Gets original image.
    func get(
        key: ImageProgressMemoryCacheOriginalKey
    ) -> Task<PlatformImage, any Error>?
    
    /// Gets resized image.
    func get(
        key: ImageProgressMemoryCacheResizedKey
    ) -> Task<PlatformImage, any Error>?
    
    // MARK: Operation - Set
    /// Sets original image.
    func set(
        key: ImageProgressMemoryCacheOriginalKey,
        task: Task<PlatformImage, any Error>
    )
    
    /// Sets resized image.
    func set(
        key: ImageProgressMemoryCacheResizedKey,
        task: Task<PlatformImage, any Error>
    )

    // MARK: Operation - Delete
    /// Deletes original image.
    func delete(
        key: ImageProgressMemoryCacheOriginalKey,
        cancel: Bool
    )
    
    /// Deletes resized image.
    func delete(
        key: ImageProgressMemoryCacheResizedKey,
        deleteAllSizes: Bool,
        cancel: Bool
    )
    
    // MARK: Operation - Delete All
    /// Deletes all images.
    func deleteAll(
        type: ImageProgressMemoryCacheCacheType,
        cancel: Bool
    )
}

/// Image cache type.
@OptionSetRepresentation
nonisolated public struct ImageProgressMemoryCacheCacheType: Sendable {
    private enum Options: Int {
        case original
        case resized
    }
}

/// Original key.
nonisolated public final class ImageProgressMemoryCacheOriginalKey: NSObject, Sendable {
    // MARK: Properties
    /// Image parameter.
    public let parameter: ImageRepositoryParameter

    // MARK: Initializers
    /// Initializes `ImageProgressMemoryCacheOriginalKey`.
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
nonisolated public final class ImageProgressMemoryCacheResizedKey: NSObject, Sendable {
    // MARK: Properties
    /// Image parameter.
    public let parameter: ImageRepositoryParameter
    
    /// Image width.
    public let width: CGFloat
    
    /// Image height.
    public let height: CGFloat

    // MARK: Initializers
    /// Initializes `ImageProgressMemoryCacheResizedKey`.
    public init(
        parameter: ImageRepositoryParameter,
        size: CGSize
    ) {
        let quantizedSize: CGSize = size.quantized()
        
        self.parameter = parameter
        self.width = quantizedSize.width
        self.height = quantizedSize.height
    }
    
    /// Initializes `ImageProgressMemoryCacheResizedKey`.
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
