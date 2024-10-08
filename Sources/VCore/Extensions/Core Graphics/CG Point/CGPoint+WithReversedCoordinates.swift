//
//  CGPoint+WithReversedCoordinates.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.04.23.
//

import CoreGraphics

// MARK: - CG Point + With Reversed Coordinates
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
            CGPoint(x: y, y: x)
        } else {
            self
        }
    }
}
