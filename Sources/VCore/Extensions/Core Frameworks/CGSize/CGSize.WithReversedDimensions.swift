//
//  CGSize.WithReversedDimensions.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import CoreGraphics

// MARK: - Size with Reversed Dimensions
extension CGSize {
    /// Returns `CGSize` with reversed `width` and `height` if condition is met..
    ///
    ///     let size: CGSize = .init(width: 3, height: 4)
    ///         .withReversedDimensions() // 4x3
    ///
    public func withReversedDimensions(
        _ condition: Bool = true
    ) -> Self {
        if condition {
            return CGSize(width: height, height: width)
        } else {
            return self
        }
    }
}
