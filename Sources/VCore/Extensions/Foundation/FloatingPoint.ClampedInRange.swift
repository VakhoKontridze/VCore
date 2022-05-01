//
//  FloatingPoint.ClampedInRange.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/9/21.
//

import Foundation

// MARK: - Number Clamped in Range
extension FloatingPoint {
    /// Clamps value in range.
    ///
    /// Usage Example:
    ///
    ///     var value1: Double = 0.0; value1.clamp(in: 1...10) // 1.0
    ///     var value2: Double = 5.0; value2.clamp(in: 1...10) // 5.0
    ///     var value3: Double = 11.0; value3.clamp(in: 1...10) // 10.0
    ///
    ///     var value4: Double = 0.0; value4.clamp(in: 1...10, step: 3) // 1.0
    ///     var value5: Double = 5.0; value5.clamp(in: 1...10, step: 3) // 4.0
    ///     var value6: Double = 11.0; value6.clamp(in: 1...10, step: 3) // 10.0
    ///
    public mutating func clamp(
        in range: ClosedRange<Self>,
        step: Self? = nil
    ) {
        self = self.clamped(in: range, step: step)
    }
    
    /// Clamps value in range.
    ///
    /// Usage Example:
    ///
    ///     let value1: Double = 0.0.clamped(in: 1...10) // 1.0
    ///     let value2: Double = 5.0.clamped(in: 1...10) // 5.0
    ///     let value3: Double = 11.0.clamped(in: 1...10) // 10.0
    ///
    ///     let value4: Double = 0.0.clamped(in: 1...10, step: 3) // 1.0
    ///     let value5: Double = 5.0.clamped(in: 1...10, step: 3) // 4.0
    ///     let value6: Double = 11.0.clamped(in: 1...10, step: 3) // 10.0
    ///
    public func clamped(
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
    
    /// Clamps value between `min` and `max` values.
    ///
    /// Usage Example:
    ///
    ///     var value1: Double = 0.0; value1.clamp(in: 1...10) // 1.0
    ///     var value2: Double = 5.0; value2.clamp(in: 1...10) // 5.0
    ///     var value3: Double = 11.0; value3.clamp(in: 1...10) // 10.0
    ///
    ///     var value4: Double = 0.0; value4.clamp(in: 1...10, step: 3) // 1.0
    ///     var value5: Double = 5.0; value5.clamp(in: 1...10, step: 3) // 4.0
    ///     var value6: Double = 11.0; value6.clamp(in: 1...10, step: 3) // 10.0
    ///
    public mutating func clamp(
        min: Self,
        max: Self,
        step: Self? = nil
    ) {
        self = self.clamped(min: min, max: max, step: step)
    }
    
    /// Returns value clamped between `min` and `max` values.
    ///
    /// Usage Example:
    ///
    ///     let value1: Double = 0.0.clamped(min: 1, max: 10) // 1.0
    ///     let value2: Double = 5.0.clamped(min: 1, max: 10) // 5.0
    ///     let value3: Double = 11.0.clamped(min: 1, max: 10) // 10.0
    ///
    ///     let value4: Double = 0.0.clamped(min: 1, max: 10, step: 3) // 1.0
    ///     let value5: Double = 5.0.clamped(min: 1, max: 10, step: 3) // 4.0
    ///     let value6: Double = 11.0.clamped(min: 1, max: 10, step: 3) // 10.0
    ///
    public func clamped(
        min: Self,
        max: Self,
        step: Self? = nil
    ) -> Self {
        clamped(in: min...max, step: step)
    }
}
