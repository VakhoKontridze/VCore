//
//  ImageProgressMemoryCacheConfiguration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import Foundation

/// Configuration for `ImageProgressMemoryCache`.
@MemberwiseInitializable
nonisolated public struct ImageProgressMemoryCacheConfiguration: Sendable {
    // MARK: Properties
    /// Maximum number of objects the cache should hold.
    public var countLimit: Int
    
    // MARK: Initializers
    /// Default instance.
    public static var `default`: Self {
        .init(
            countLimit: 1000
        )
    }
}
