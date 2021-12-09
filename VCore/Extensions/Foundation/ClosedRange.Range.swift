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
    public var range: Bound {
        upperBound - lowerBound
    }
}
