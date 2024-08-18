//
//  Range+ReversedArrayOnCondition.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import Foundation

// MARK: - Range + Reversed Array on Condition
extension Range where Bound: FixedWidthInteger {
    /// Returns reversed `Array` from `Range` if condition is met.
    ///
    ///     let number: [Int] = 1..<3 // [2, 1]
    ///         .reversedArray()
    ///
    public func reversedArray(
        _ condition: Bool
    ) -> [Bound] {
        Array(self).reversed(condition)
    }
}
