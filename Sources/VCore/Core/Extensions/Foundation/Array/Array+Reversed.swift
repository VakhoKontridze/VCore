//
//  Array+Reversed.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import Foundation

nonisolated extension Array {
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
    ///     array.reverse(reversesOrder)
    ///
    mutating public func reverse(
        _ condition: Bool
    ) {
        if condition {
            reverse()
        }
    }
}
