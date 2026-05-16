//
//  ImageDiskCacheConfiguration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import Foundation

/// Configuration for `ImageDiskCache`.
@MemberwiseInitializable
nonisolated public struct ImageDiskCacheConfiguration: Sendable {
    // MARK: Properties
    /// JPEG compression quality for original images. `1.0` = lossless, `0.0` = maximum compression.
    public var originalCompressionQuality: CGFloat

    /// JPEG compression quality for resized images.
    public var resizedCompressionQuality: CGFloat

    /// Maximum total byte size of the originals directory before LRU eviction kicks in.
    public var originalMaxBytes: Int

    /// Maximum total byte size of the resized directory before LRU eviction kicks in.
    public var resizedMaxBytes: Int

    /// Maximum age of a file since last access before it is evicted regardless of size budget.
    public var maxAge: TimeInterval

    // MARK: Initializers
    /// Default instance.
    public static var `default`: Self {
        .init(
            originalCompressionQuality: 0.9,
            resizedCompressionQuality: 0.7,
            
            originalMaxBytes: 500 * 1_024 * 1_024,
            resizedMaxBytes: 200 * 1_024 * 1_024,
            
            maxAge: 7 * 24 * 3_600
        )
    }
}
