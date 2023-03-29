//
//  AutoPrecisionNumberFormatter.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

import Foundation

// MARK: - Extension
extension Double {
    /// Returns `String` from `Double` with specified min and max fractions.
    ///
    ///     let rounded: String = 3.1415.rounded(maxFractions: 2) // "3.14"
    ///
    public func rounded(
        minFractions: Int = 0,
        maxFractions: Int
    ) -> String? {
        AutoPrecisionNumberFormatter(minFractions: minFractions, maxFractions: maxFractions)
            .string(from: self)
    }
}

// MARK: - Auto Precision Number Formatter
/// Auto Precision Number Formatter.
///
/// Rounds number to fractions specified by `min` and `max`.
/// If number ends with zeroes, they will be removed until `min` fraction requirement is met.
///
///     let formatter: AutoPrecisionNumberFormatter = .init(maxFractions: 2)
///     let rounded: String = formatter.string(from: 3.1415) // "3.14"
///
public struct AutoPrecisionNumberFormatter {
    // MARK: Properties
    /// Minimum number of fractions. Set to `0`.
    public var minFractions: Int
    
    /// Maximum number of fractions.
    public var maxFractions: Int
    
    // MARK: Initializers
    /// Initializes `AutoPrecisionNumberFormatter`.
    public init(
        minFractions: Int = 0,
        maxFractions: Int
    ) {
        self.minFractions = minFractions
        self.maxFractions = maxFractions
    }

    // MARK: Formatting
    /// Returns `String` from number with specified format.
    public func string(from number: Double) -> String? {
        guard
            minFractions >= 0,
            maxFractions >= 0,
            maxFractions >= minFractions
        else {
            return nil
        }
        
        let numberFormatter: NumberFormatter = .init()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = minFractions
        numberFormatter.maximumFractionDigits = maxFractions
        
        return numberFormatter.string(from: NSNumber(value: number))
    }
}
