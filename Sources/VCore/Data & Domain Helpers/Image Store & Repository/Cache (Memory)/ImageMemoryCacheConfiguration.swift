//
//  ImageMemoryCacheConfiguration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import Foundation

/// Configuration for `ImageMemoryCache`.
@MemberwiseInitializable
nonisolated public struct ImageMemoryCacheConfiguration: Sendable {
    // MARK: Properties
    /// Maximum number of objects the cache should hold.
    public var countLimit: Int
    
    /// Maximum total cost that the cache can hold before it starts evicting objects.
    public var totalCostLimit: Int
    
    // MARK: Initializers
    /// Default instance for "original" images.
    public static var defaultMemoryOriginal: Self {
        .init(
            countLimit: 50,
            totalCostLimit: 100 * 1_024 * 1_024
        )
    }
    
    /// Default instance for "resized" images.
    public static var defaultMemoryResized: Self {
        .init(
            countLimit: 300,
            totalCostLimit: 200 * 1_024 * 1_024
        )
    }
}
