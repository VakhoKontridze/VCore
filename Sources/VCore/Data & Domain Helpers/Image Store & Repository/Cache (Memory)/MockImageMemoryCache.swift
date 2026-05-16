//
//  MockImageMemoryCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

#if DEBUG

import Foundation

/// Mock image memory cache.
public actor MockImageMemoryCache: ImageMemoryCacheProtocol {
    // MARK: Properties - Images
    private let image: PlatformImage? = .init(
        size: CGSize(dimension: 1_000),
        color: PlatformColor.systemBlue
    )
    
    // MARK: Initializers
    /// Initializes `MockImageMemoryCache`.
    public init() {}
    
    // MARK: Operations
    public func get(
        key: ImageMemoryCache_OriginalKey
    ) -> PlatformImage? {
        image
    }
    
    public func get(
        key: ImageMemoryCache_ResizedKey
    ) -> PlatformImage? {
        PlatformImage(
            size: CGSize(width: key.width, height: key.height),
            color: PlatformColor.systemBlue
        )
    }
    
    public func set(
        key: ImageMemoryCache_OriginalKey,
        image: PlatformImage
    ) {}
    
    public func set(
        key: ImageMemoryCache_ResizedKey,
        image: PlatformImage
    ) {}
    
    public func delete(
        key: ImageMemoryCache_OriginalKey
    ) {}
    
    public func delete(
        key: ImageMemoryCache_ResizedKey
    ) {}
    
    public func deleteAll(
        type: ImageMemoryCache_CacheType
    ) {}
}

#endif
