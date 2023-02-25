//
//  CGSize.WithReversedDimensions.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import CoreGraphics

// MARK: - Size with Reversed Dimensions
extension CGSize {
    /// Returns `CGSize` with reversed `width` and `height`.
    ///
    ///     let size: CGSize = .init(width: 3, height: 4)
    ///         .withReversedDimensions() // (width: 4, height: 3)
    ///
    func withReversedDimensions() -> Self {
        withReversedDimensions(if: true)
    }
}

// MARK: - Size with Reversed Dimensions on Condition
extension CGSize {
    /// Returns `CGSize` with reversed `width` and `height` if condition is met.
    ///
    ///     let size: CGSize = .init(width: 3, height: 4)
    ///         .withReversedDimensions(if: reversesDimensions)
    ///
    func withReversedDimensions(if condition: Bool) -> Self {
        if condition {
            return .init(width: height, height: width)
        } else {
            return self
        }
    }
}
