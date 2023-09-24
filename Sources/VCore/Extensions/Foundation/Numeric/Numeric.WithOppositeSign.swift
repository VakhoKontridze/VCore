//
//  Numeric.WithOppositeSign.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import Foundation

// MARK: - Numeric with Opposite Sign
extension Numeric {
    /// Returns `Numeric` value with opposite sign.
    ///
    ///     let number: Int = 10    // -10
    ///         .withOppositeSign()
    ///
    public func withOppositeSign() -> Self {
        withOppositeSign(if: true)
    }
}

// MARK: - Numeric with Opposite Sign on Condition
extension Numeric {
    /// Returns `Numeric` value with opposite sign if condition is met.
    ///
    ///     let number: Int = 10
    ///         .withOppositeSign(if: reversesSign)
    ///
    public func withOppositeSign(if condition: Bool) -> Self {
        if condition {
            self * -1
        } else {
            self
        }
    }
}
