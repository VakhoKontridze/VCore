//
//  AbsoluteFractionMeasurement.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16.07.24.
//

import CoreGraphics

// MARK: - Absolute/Fraction Measurement
/// Length measurement represented in absolute or fractional values.
public enum AbsoluteFractionMeasurement: Equatable, Hashable {
    // MARK: Cases
    /// Absolute measurement.
    case absolute(CGFloat)

    /// Fraction measurement.
    case fraction(CGFloat)

    // MARK: Mapping
    /// Converts fractional to absolute dimension.
    public func toAbsolute(
        dimension: CGFloat
    ) -> CGFloat {
        switch self {
        case .absolute(let value): value
        case .fraction(let value): value * dimension
        }
    }

    /// Converts absolute to fractional dimension.
    public func toFractions(
        dimension: CGFloat
    ) -> CGFloat {
        switch self {
        case .absolute(let value): value / dimension
        case .fraction(let value): value
        }
    }
}
