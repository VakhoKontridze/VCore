//
//  ImageProgressMemoryCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if canImport(UIKit)
public import UIKit
#elseif canImport(AppKit)
public import AppKit
#endif

/// Image progress memory cache.
///
/// Shares an in-flight operation between callers with the same key,
/// and cancels it only when the last waiter is cancelled.
nonisolated public protocol ImageProgressMemoryCache: AnyObject, Sendable {
    // MARK: Operation - Run
    /// Runs operation for original image, or joins an in-flight one with the same key.
    func run(
        key: ImageProgressMemoryCacheOriginalKey,
        operation: @Sendable @escaping () async throws -> PlatformImage
    ) async throws -> PlatformImage
    
    /// Runs operation for resized image, or joins an in-flight one with the same key.
    func run(
        key: ImageProgressMemoryCacheResizedKey,
        operation: @Sendable @escaping () async throws -> PlatformImage
    ) async throws -> PlatformImage
    
    // MARK: Operation - Cancel
    /// Cancels in-flight original image for all waiters.
    func cancel(
        key: ImageProgressMemoryCacheOriginalKey
    )
    
    /// Cancels in-flight resized image for all waiters.
    func cancel(
        key: ImageProgressMemoryCacheResizedKey,
        cancelAllSizes: Bool
    )
    
    // MARK: Operation - Cancel All
    /// Cancels all in-flight images for all waiters.
    func cancelAll(
        type: ImageProgressMemoryCacheCacheType
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
        
        return VCore::isEqual(
            self,
            to: other,
            by: \.parameter
        )
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
        
        return VCore::isEqual(
            self,
            to: other,
            by: \.parameter, \.width, \.height
        )
    }
}
