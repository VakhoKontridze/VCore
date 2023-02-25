//
//  BinaryInteger.ClampedToCloseRange.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 252.23.
//

import Foundation

// MARK: - Binary Integer Clamped to Closed Range
extension BinaryInteger {
    /// Clamps value in range.
    ///
    ///     let value1: Int = 0.clamped(to: 1...10) // 1
    ///     let value2: Int = 5.clamped(to: 1...10) // 5
    ///     let value3: Int = 11.clamped(to: 1...10) // 10
    ///
    ///     let value4: Int = 0.clamped(to: 1...10, step: 3) // 1
    ///     let value5: Int = 5.clamped(to: 1...10, step: 3) // 4
    ///     let value6: Int = 11.clamped(to: 1...10, step: 3) // 10
    ///
    public func clamped(
        to range: ClosedRange<Self>,
        step: Self? = nil
    ) -> Self {
        switch step {
        case nil:
            if self > range.upperBound {
                return range.upperBound
            } else if self < range.lowerBound {
                return range.lowerBound
            } else {
                return self
            }
            
        case let step?:
            let stepRoundedValue: Self = range.lowerBound + ((self - range.lowerBound) / step) * step
            return stepRoundedValue.clamped(to: range)
        }
    }
    
    /// Clamps value in range.
    ///
    ///     var value1: Int = 0; value1.clamp(to: 1...10) // 1
    ///     var value2: Int = 5; value2.clamp(to: 1...10) // 5
    ///     var value3: Int = 11; value3.clamp(to: 1...10) // 10
    ///
    ///     var value4: Int = 0; value4.clamp(to: 1...10, step: 3) // 1
    ///     var value5: Int = 5; value5.clamp(to: 1...10, step: 3) // 4
    ///     var value6: Int = 11; value6.clamp(to: 1...10, step: 3) // 10
    ///
    mutating public func clamp(
        to range: ClosedRange<Self>,
        step: Self? = nil
    ) {
        self = clamped(to: range, step: step)
    }
    
    /// Returns value clamped between `min` and `max` values.
    ///
    ///     let value1: Int = 0.clamped(min: 1, max: 10) // 1
    ///     let value2: Int = 5.clamped(min: 1, max: 10) // 5
    ///     let value3: Int = 11.clamped(min: 1, max: 10) // 10
    ///
    ///     let value4: Int = 0.clamped(min: 1, max: 10, step: 3) // 1
    ///     let value5: Int = 5.clamped(min: 1, max: 10, step: 3) // 4
    ///     let value6: Int = 11.clamped(min: 1, max: 10, step: 3) // 10
    ///
    public func clamped(
        min: Self,
        max: Self,
        step: Self? = nil
    ) -> Self {
        clamped(to: min...max, step: step)
    }
    
    /// Clamps value between `min` and `max` values.
    ///
    ///     var value1: Int = 0; value1.clamp(min: 1, max: 10) // 1
    ///     var value2: Int = 5; value2.clamp(min: 1, max: 10) // 5
    ///     var value3: Int = 11; value3.clamp(min: 1, max: 10) // 10
    ///
    ///     var value4: Int = 0; value4.clamp(min: 1, max: 10, step: 3) // 1
    ///     var value5: Int = 5; value5.clamp(min: 1, max: 10, step: 3) // 4
    ///     var value6: Int = 11; value6.clamp(min: 1, max: 10, step: 3) // 10
    ///
    mutating public func clamp(
        min: Self,
        max: Self,
        step: Self? = nil
    ) {
        self = clamped(min: min, max: max, step: step)
    }
}
