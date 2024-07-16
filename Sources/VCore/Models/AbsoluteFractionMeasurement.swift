//
//  AbsoluteFractionMeasurement.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16.07.24.
//

import CoreGraphics

// MARK: - Absolute/Fraction Measurement
/// Length measurement that represents absolute or fractional values.
public enum AbsoluteFractionMeasurement: Equatable, Hashable {
    // MARK: Cases
    /// Absolute measurement.
    case absolute(CGFloat)

    /// Fraction measurement.
    case fraction(CGFloat)

    // MARK: Mapping
    /// Converts fractional to absolute dimension.
    public func toAbsolute(
        in containerDimension: CGFloat
    ) -> CGFloat {
        switch self {
        case .absolute(let value): value
        case .fraction(let value): value * containerDimension
        }
    }

    /// Converts absolute to fractional dimension.
    public func toFractions(
        in containerDimension: CGFloat
    ) -> CGFloat {
        switch self {
        case .absolute(let value): value / containerDimension
        case .fraction(let value): value
        }
    }
}
