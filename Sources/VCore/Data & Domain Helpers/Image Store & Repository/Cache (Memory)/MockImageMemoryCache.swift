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
nonisolated open class MockImageMemoryCache: ImageMemoryCache, @unchecked Sendable {
    // MARK: Properties - Images
    private let image: PlatformImage? = .init(
        size: CGSize(dimension: 500),
        color: PlatformColor.systemBlue
    )
    
    // MARK: Initializers
    /// Initializes `MockImageMemoryCache`.
    public init() {}
    
    // MARK: Operations
    open func get(
        key: ImageMemoryCacheOriginalKey
    ) -> PlatformImage? {
        image
    }
    
    open func get(
        key: ImageMemoryCacheResizedKey
    ) -> PlatformImage? {
        image
    }
    
    open func set(
        key: ImageMemoryCacheOriginalKey,
        image: PlatformImage
    ) {}
    
    open func set(
        key: ImageMemoryCacheResizedKey,
        image: PlatformImage
    ) {}
    
    open func delete(
        key: ImageMemoryCacheOriginalKey
    ) {}
    
    open func delete(
        key: ImageMemoryCacheResizedKey,
        deleteAllSizes: Bool
    ) {}
    
    open func deleteAll(
        type: ImageMemoryCacheCacheType
    ) {}
}

#endif
