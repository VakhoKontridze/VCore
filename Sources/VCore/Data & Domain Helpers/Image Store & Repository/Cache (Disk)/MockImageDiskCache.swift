//
//  MockImageDiskCache.swift
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

/// Mock image disk cache.
nonisolated open class MockImageDiskCache: ImageDiskCache, @unchecked Sendable {
    // MARK: Properties - Images
    private let image: PlatformImage? = .init(
        size: CGSize(dimension: 500),
        color: PlatformColor.systemBlue
    )
    
    // MARK: Initializers
    /// Initializes `MockImageDiskCache`.
    public init() {}
    
    // MARK: Operations
    open func get(
        key: ImageDiskCacheOriginalKey
    ) -> PlatformImage? {
        image
    }
    
    open func get(
        key: ImageDiskCacheResizedKey
    ) -> PlatformImage? {
        image
    }
    
    open func set(
        key: ImageDiskCacheOriginalKey,
        image: PlatformImage
    ) {}
    
    open func set(
        key: ImageDiskCacheResizedKey,
        image: PlatformImage
    ) {}
    
    open func delete(
        key: ImageDiskCacheOriginalKey
    ) {}
    
    open func delete(
        key: ImageDiskCacheResizedKey,
        deleteAllSizes: Bool
    ) {}
    
    open func deleteAll(
        type: ImageDiskCacheCacheType
    ) {}
    
    open func evictIfNeeded() {}
}

#endif
