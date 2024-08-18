//
//  ClosedRange+ReversedArrayOnCondition.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.08.23.
//

import Foundation

// MARK: - Closed Range + Reversed Array on Condition
extension ClosedRange where Bound: FixedWidthInteger {
    /// Returns reversed `Array` from `ClosedRange` if condition is met.
    ///
    ///     let number: [Int] = 1...3 // [3, 2, 1]
    ///         .reversedArray()
    ///
    public func reversedArray(
        _ condition: Bool
    ) -> [Bound] {
        Array(self).reversed(condition)
    }
}
