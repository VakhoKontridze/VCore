//
//  CGPoint.WithReversedCoordinates.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.04.23.
//

import CoreGraphics

// MARK: - CGPoint with Reversed Coordinates
extension CGPoint {
    /// Returns `CGPoint` with reversed `x` and `y`.
    ///
    ///     let coordinates: CGPoint = .init(x: 100, y: 200)
    ///         .withReversedCoordinates() // 200x100
    ///
    public func withReversedCoordinates(
        _ condition: Bool = true
    ) -> Self {
        if condition {
            return CGPoint(x: y, y: x)
        } else {
            return self
        }
    }
}
