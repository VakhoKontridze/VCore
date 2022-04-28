//
//  FloatingPoint.FixedInRange.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/9/21.
//

import Foundation

// MARK: - Number Bound in Range
extension FloatingPoint {
    /// Combination of `min` and `max` function that returns a number fixed in a given range.
    ///
    /// Usage Example:
    ///
    ///     let value1: Double = 0.0.bound(in: 1...10) // 1.0
    ///     let value2: Double = 5.0.bound(in: 1...10) // 5.0
    ///     let value3: Double = 11.0.bound(in: 1...10) // 10.0
    ///
    ///     let value4: Double = 0.0.bound(in: 1...10, step: 3) // 1.0
    ///     let value5: Double = 5.0.bound(in: 1...10, step: 3) // 4.0
    ///     let value6: Double = 11.0.bound(in: 1...10, step: 3) // 10.0
    ///
    public func bound(
        in range: ClosedRange<Self>,
        step: Self? = nil
    ) -> Self {
        switch (self, step) {
        case (...range.lowerBound, _): return range.lowerBound
        case (range.upperBound..., _): return range.upperBound
        case (_, nil): return self
        case (_, let step?): return self.rounded(range: range, step: step)
        }
    }
    
    /// Combination of `min` and `max` function that returns a number fixed in a given range.
    ///
    /// Usage Example:
    ///
    ///     let value1: Double = 0.0.bound(min: 1, max: 10) // 1.0
    ///     let value2: Double = 5.0.bound(min: 1, max: 10) // 5.0
    ///     let value3: Double = 11.0.bound(min: 1, max: 10) // 10.0
    ///
    ///     let value4: Double = 0.0.bound(min: 1, max: 10, step: 3) // 1.0
    ///     let value5: Double = 5.0.bound(min: 1, max: 10, step: 3) // 4.0
    ///     let value6: Double = 11.0.bound(min: 1, max: 10, step: 3) // 10.0
    ///
    public func bound(
        min: Self,
        max: Self,
        step: Self? = nil
    ) -> Self {
        bound(in: min...max, step: step)
    }
}
