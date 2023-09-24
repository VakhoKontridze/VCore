//
//  PointPixelMeasurement.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.08.23.
//

import CoreGraphics

// MARK: - Point Pixel Measurement
/// Display measurement that represents points or pixels.
public enum PointPixelMeasurement: Equatable, Hashable {
    // MARK: Cases
    /// Point measurement.
    case points(CGFloat)

    /// Pixel measurement.
    case pixels(Int)

    // MARK: Conversion
    /// Converts value to points based on scale.
    public func toPoints(scale: CGFloat) -> CGFloat {
        switch self {
        case .points(let value): value
        case .pixels(let value): CGFloat(value) / scale
        }
    }

    /// Converts value to pixels based on scale.
    public func toPixels(scale: CGFloat) -> Int {
        switch self {
        case .points(let value): Int((value * scale).rounded())
        case .pixels(let value): value
        }
    }
}
