//
//  MockImageMemoryCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if DEBUG

#if canImport(UIKit)
public import UIKit
#elseif canImport(AppKit)
public import AppKit
#endif

/// Mock image memory cache.
nonisolated open class MockImageMemoryCache: ImageMemoryCache, @unchecked Sendable {
    // MARK: Properties - Images
    private let image: PlatformImage? = .init(
        size: CGSize(dimension: 500),
        color: {
#if os(watchOS)
            UIColor.blue
#else
            PlatformColor.systemBlue
#endif
        }()
    )
    
    // MARK: Initializers
    /// Initializes `MockImageMemoryCache`.
    public init() {}
    
    // MARK: Operation - Get
    /// Gets original image.
    open func get(
        key: ImageMemoryCacheOriginalKey
    ) -> PlatformImage? {
        image
    }
    
    /// Gets resized image.
    open func get(
        key: ImageMemoryCacheResizedKey
    ) -> PlatformImage? {
        image
    }
    
    // MARK: Operation - Set
    /// Sets original image.
    open func set(
        key: ImageMemoryCacheOriginalKey,
        image: PlatformImage
    ) {}
    
    /// Sets resized image.
    open func set(
        key: ImageMemoryCacheResizedKey,
        image: PlatformImage
    ) {}
    
    // MARK: Operation - Delete
    /// Deletes original image.
    open func delete(
        key: ImageMemoryCacheOriginalKey
    ) {}
    
    /// Deletes resized image.
    open func delete(
        key: ImageMemoryCacheResizedKey,
        deleteAllSizes: Bool
    ) {}
    
    // MARK: Operation - Delete All
    /// Deletes all images.
    open func deleteAll(
        type: ImageMemoryCacheCacheType
    ) {}
}

#endif
