//
//  MockImageDiskCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if canImport(UIKit)
public import UIKit
#elseif canImport(AppKit)
public import AppKit
#endif

/// Mock image disk cache.
nonisolated open class MockImageDiskCache: ImageDiskCache, @unchecked Sendable {
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
    /// Initializes `MockImageDiskCache`.
    public init() {}
    
    // MARK: Operation - Get
    /// Gets original image.
    open func get(
        key: ImageDiskCacheOriginalKey
    ) -> PlatformImage? {
        image
    }
    
    /// Gets resized image.
    open func get(
        key: ImageDiskCacheResizedKey
    ) -> PlatformImage? {
        image
    }
    
    // MARK: Operation - Set
    /// Sets original image.
    open func set(
        key: ImageDiskCacheOriginalKey,
        image: PlatformImage
    ) {}
    
    /// Sets resized image.
    open func set(
        key: ImageDiskCacheResizedKey,
        image: PlatformImage
    ) {}
    
    // MARK: Operation - Delete
    /// Deletes original image.
    open func delete(
        key: ImageDiskCacheOriginalKey
    ) {}
    
    /// Deletes resized image.
    open func delete(
        key: ImageDiskCacheResizedKey,
        deleteAllSizes: Bool
    ) {}
    
    // MARK: Operation - Delete All
    /// Deletes all images.
    open func deleteAll(
        type: ImageDiskCacheCacheType
    ) {}
    
    // MARK: Operation - Evict
    /// Removes image that exceed `maxAge` or, if total size exceeds `maxBytes`.
    /// Evicts least-recently-used image until within budget.
    ///
    /// Drive this from `UIApplication.didEnterBackgroundNotification`,
    /// so eviction runs while the user is not looking at images.
    open func evictIfNeeded() {}
}
