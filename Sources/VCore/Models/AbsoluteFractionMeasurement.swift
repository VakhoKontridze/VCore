//
//  AbsoluteFractionMeasurement.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16.07.24.
//

import CoreGraphics

/// Length measurement represented in absolute or fractional values.
public enum AbsoluteFractionMeasurement: Equatable, Hashable, Sendable {
    // MARK: Cases
    /// Absolute measurement.
    case absolute(CGFloat)

    /// Fraction measurement.
    case fraction(CGFloat)
    
    // MARK: Initializers
    /// Initializes `AbsoluteFractionMeasurement` with `0` value.
    public static var zero: Self {
        .absolute(0)
    }

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
    public func toFraction(
        dimension: CGFloat
    ) -> CGFloat {
        switch self {
        case .absolute(let value): value / dimension
        case .fraction(let value): value
        }
    }
}
