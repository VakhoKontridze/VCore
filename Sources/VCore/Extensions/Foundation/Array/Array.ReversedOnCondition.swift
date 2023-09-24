//
//  Array.ReversedOnCondition.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import Foundation

// MARK: - Array Reversed on Condition
extension Array {
    /// Returns reversed `Array` if condition is met.
    ///
    ///     ["London", "Paris", "New York"]
    ///         .reversed(reversesOrder)
    ///
    public func reversed(
        _ condition: Bool
    ) -> Self {
        if condition {
            self.reversed()
        } else {
            self
        }
    }

    /// Reverses `Array` if condition is met.
    ///
    ///     var array: [String] = ["London", "Paris", "New York"]
    ///     array.reversed(reversesOrder)
    ///
    mutating public func reverse(
        _ condition: Bool
    ) {
        if condition {
            reverse()
        }
    }
}
