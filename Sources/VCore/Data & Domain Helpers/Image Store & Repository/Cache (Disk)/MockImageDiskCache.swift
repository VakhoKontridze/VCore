//
//  MockImageDiskCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if DEBUG

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Mock image disk cache.
nonisolated public final class MockImageDiskCache: ImageDiskCache {
    // MARK: Properties - Images
    private let image: PlatformImage? = .init(
        size: CGSize(dimension: 500),
        color: PlatformColor.systemBlue
    )
    
    // MARK: Initializers
    /// Initializes `MockImageDiskCache`.
    public init() {}
    
    // MARK: Operations
    public func get(
        key: ImageDiskCacheOriginalKey
    ) -> PlatformImage? {
        image
    }
    
    public func get(
        key: ImageDiskCacheResizedKey
    ) -> PlatformImage? {
        image
    }
    
    public func set(
        key: ImageDiskCacheOriginalKey,
        image: PlatformImage
    ) {}
    
    public func set(
        key: ImageDiskCacheResizedKey,
        image: PlatformImage
    ) {}
    
    public func delete(
        key: ImageDiskCacheOriginalKey
    ) {}
    
    public func delete(
        key: ImageDiskCacheResizedKey,
        deleteAllSizes: Bool
    ) {}
    
    public func deleteAll(
        type: ImageDiskCacheCacheType
    ) {}
    
    public func evictIfNeeded() {}
}

#endif
