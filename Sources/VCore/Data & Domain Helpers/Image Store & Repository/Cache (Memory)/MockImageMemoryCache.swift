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
nonisolated public final class MockImageMemoryCache: ImageMemoryCacheProtocol {
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
        key: ImageMemoryCache_OriginalKey
    ) -> PlatformImage? {
        image
    }
    
    public func get(
        key: ImageMemoryCache_ResizedKey
    ) -> PlatformImage? {
        image
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
        key: ImageMemoryCache_ResizedKey,
        deleteAllSizes: Bool
    ) {}
    
    public func deleteAll(
        type: ImageMemoryCache_CacheType
    ) {}
}

#endif
