//
//  Numeric+WithOppositeSign.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import Foundation

// MARK: - Numeric + With Opposite Sign
extension Numeric {
    /// Returns `Numeric` value with opposite sign if condition is met.
    ///
    ///     let number: Int = 10 // -10
    ///         .withOppositeSign()
    ///
    public func withOppositeSign(
        _ condition: Bool = true
    ) -> Self {
        if condition {
            self * -1
        } else {
            self
        }
    }
}
