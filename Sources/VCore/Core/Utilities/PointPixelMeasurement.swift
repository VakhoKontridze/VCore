//
//  PointPixelMeasurement.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.08.23.
//

import CoreGraphics

/// Display measurement represented in points or pixels.
public nonisolated enum PointPixelMeasurement: Equatable, Hashable, Sendable {
    // MARK: Cases
    /// Point measurement.
    case points(CGFloat)

    /// Pixel measurement.
    case pixels(Int)

    // MARK: Mapping
    /// Converts pixels to points based on scale.
    public func toPoints(scale: CGFloat) -> CGFloat {
        switch self {
        case .points(let value):
            value
        
        case .pixels(let value):
            if scale == 0 {
                0
            } else {
                CGFloat(value) / scale
            }
        }
    }

    /// Converts value to pixels based on scale.
    public func toPixels(
        scale: CGFloat,
        roundingRule: FloatingPointRoundingRule = .up
    ) -> Int {
        switch self {
        case .points(let value): Int((value * scale).rounded(roundingRule))
        case .pixels(let value): value
        }
    }
}
