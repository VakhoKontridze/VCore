//
//  ClosedRange+BoundRange.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/9/21.
//

import Foundation

// MARK: - Closed Range + Bound Range
extension ClosedRange where Bound: AdditiveArithmetic {
    /// Difference between `upperBound` and `lowerBound`.
    ///
    ///     let boundRange: Double = (3...10).boundRange // 7.0
    ///
    public var boundRange: Bound {
        upperBound - lowerBound
    }
}
