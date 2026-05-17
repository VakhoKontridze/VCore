//
//  MockImageDiskCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if DEBUG

import Foundation

/// Mock image disk cache.
public final class MockImageDiskCache: ImageDiskCacheProtocol {
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
        key: ImageDiskCache_OriginalKey
    ) -> PlatformImage? {
        image
    }
    
    public func get(
        key: ImageDiskCache_ResizedKey
    ) -> PlatformImage? {
//        PlatformImage(
//            size: CGSize(width: key.width, height: key.height),
//            color: PlatformColor.systemBlue
//        )
        image
    }
    
    public func set(
        key: ImageDiskCache_OriginalKey,
        image: PlatformImage
    ) {}
    
    public func set(
        key: ImageDiskCache_ResizedKey,
        image: PlatformImage
    ) {}
    
    public func delete(
        key: ImageDiskCache_OriginalKey
    ) {}
    
    public func delete(
        key: ImageDiskCache_ResizedKey,
        deleteAllSizes: Bool
    ) {}
    
    public func deleteAll(
        type: ImageDiskCache_CacheType
    ) {}
    
    public func evictIfNeeded() {}
}

#endif
