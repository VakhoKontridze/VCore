//
//  ImageProgressMemoryCacheProtocol.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import Foundation

/// Image progress memory cache protocol.
nonisolated public protocol ImageProgressMemoryCacheProtocol: Actor {
    // MARK: Operation - Get
    /// Gets original image.
    func get(
        key: ImageProgressMemoryCache_OriginalKey
    ) -> Task<PlatformImage, any Error>?
    
    /// Gets resized image.
    func get(
        key: ImageProgressMemoryCache_ResizedKey
    ) -> Task<PlatformImage, any Error>?
    
    // MARK: Operation - Set
    /// Sets original image.
    func set(
        key: ImageProgressMemoryCache_OriginalKey,
        task: Task<PlatformImage, any Error>
    )
    
    /// Sets resized image.
    func set(
        key: ImageProgressMemoryCache_ResizedKey,
        task: Task<PlatformImage, any Error>
    )

    // MARK: Operation - Delete
    /// Deletes original image.
    func delete(
        key: ImageProgressMemoryCache_OriginalKey,
        cancel: Bool
    )
    
    /// Deletes resized image.
    func delete(
        key: ImageProgressMemoryCache_ResizedKey,
        cancel: Bool
    )
    
    // MARK: Operation - Delete All
    /// Deletes all images.
    func deleteAll(
        type: ImageProgressMemoryCache_CacheType,
        cancel: Bool
    )
}

/// Image cache type.
@OptionSetRepresentation<Int>
nonisolated public struct ImageProgressMemoryCache_CacheType: Sendable {
    private enum Options: Int {
        case original
        case resized
    }
}

/// Original key.
nonisolated public final class ImageProgressMemoryCache_OriginalKey: NSObject, Sendable {
    // MARK: Properties
    /// Image parameter.
    public let parameter: ImageRepository_Parameter

    // MARK: Initializers
    /// Initializes `ImageProgressMemoryCache_OriginalKey`.
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
nonisolated public final class ImageProgressMemoryCache_ResizedKey: NSObject, Sendable {
    // MARK: Properties
    /// Image parameter.
    public let parameter: ImageRepository_Parameter
    
    /// Image width.
    public let width: CGFloat
    
    /// Image height.
    public let height: CGFloat

    // MARK: Initializers
    /// Initializes `ImageProgressMemoryCache_ResizedKey`.
    public init(
        parameter: ImageRepository_Parameter,
        size: CGSize
    ) {
        let quantizedSize: CGSize = size.quantized()
        
        self.parameter = parameter
        self.width = quantizedSize.width
        self.height = quantizedSize.height
    }
    
    /// Initializes `ImageProgressMemoryCache_ResizedKey`.
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
