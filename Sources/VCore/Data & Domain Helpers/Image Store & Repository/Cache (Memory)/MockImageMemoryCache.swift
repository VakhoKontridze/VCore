//
//  MockImageMemoryCache.swift
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

/// Mock image memory cache.
nonisolated public final class MockImageMemoryCache: ImageMemoryCache {
    // MARK: Properties - Images
    private let image: PlatformImage? = .init(
        size: CGSize(dimension: 500),
        color: PlatformColor.systemBlue
    )
    
    // MARK: Initializers
    /// Initializes `MockImageMemoryCache`.
    public init() {}
    
    // MARK: Operations
    public func get(
        key: ImageMemoryCacheOriginalKey
    ) -> PlatformImage? {
        image
    }
    
    public func get(
        key: ImageMemoryCacheResizedKey
    ) -> PlatformImage? {
        image
    }
    
    public func set(
        key: ImageMemoryCacheOriginalKey,
        image: PlatformImage
    ) {}
    
    public func set(
        key: ImageMemoryCacheResizedKey,
        image: PlatformImage
    ) {}
    
    public func delete(
        key: ImageMemoryCacheOriginalKey
    ) {}
    
    public func delete(
        key: ImageMemoryCacheResizedKey,
        deleteAllSizes: Bool
    ) {}
    
    public func deleteAll(
        type: ImageMemoryCacheCacheType
    ) {}
}

#endif
