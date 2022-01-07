//
//  ClosedRange.Range.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/9/21.
//

import Foundation

// MARK: - Closed Range Range
extension ClosedRange where Bound: AdditiveArithmetic {
    /// Difference between `upperBound` and `lowerBound`.
    ///
    /// Usage Examle:
    ///
    ///     let range: Double = (3...10).range // 7.0
    ///
    public var range: Bound {
        upperBound - lowerBound
    }
}
