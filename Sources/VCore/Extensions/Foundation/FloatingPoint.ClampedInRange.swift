//
//  FloatingPoint.ClampedInRange.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/9/21.
//

import Foundation

// MARK: - Number Clamped in Closed Range
extension FloatingPoint {
    /// Clamps value in range.
    ///
    /// Usage Example:
    ///
    ///     let value1: Double = 0.0.clamped(to: 1...10) // 1.0
    ///     let value2: Double = 5.0.clamped(to: 1...10) // 5.0
    ///     let value3: Double = 11.0.clamped(to: 1...10) // 10.0
    ///
    ///     let value4: Double = 0.0.clamped(to: 1...10, step: 3) // 1.0
    ///     let value5: Double = 5.0.clamped(to: 1...10, step: 3) // 4.0
    ///     let value6: Double = 11.0.clamped(to: 1...10, step: 3) // 10.0
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
            let stepRoundedValue: Self = range.lowerBound + ((self - range.lowerBound) / step).rounded() * step
            return stepRoundedValue.clamped(to: range)
        }
    }
    
    /// Clamps value in range.
    ///
    /// Usage Example:
    ///
    ///     var value1: Double = 0.0; value1.clamp(to: 1...10) // 1.0
    ///     var value2: Double = 5.0; value2.clamp(to: 1...10) // 5.0
    ///     var value3: Double = 11.0; value3.clamp(to: 1...10) // 10.0
    ///
    ///     var value4: Double = 0.0; value4.clamp(to: 1...10, step: 3) // 1.0
    ///     var value5: Double = 5.0; value5.clamp(to: 1...10, step: 3) // 4.0
    ///     var value6: Double = 11.0; value6.clamp(to: 1...10, step: 3) // 10.0
    ///
    mutating public func clamp(
        to range: ClosedRange<Self>,
        step: Self? = nil
    ) {
        self = self.clamped(to: range, step: step)
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
        clamped(to: min...max, step: step)
    }
    
    /// Clamps value between `min` and `max` values.
    ///
    /// Usage Example:
    ///
    ///     var value1: Double = 0.0; value1.clamp(min: 1, max: 10) // 1.0
    ///     var value2: Double = 5.0; value2.clamp(min: 1, max: 10) // 5.0
    ///     var value3: Double = 11.0; value3.clamp(min: 1, max: 10) // 10.0
    ///
    ///     var value4: Double = 0.0; value4.clamp(min: 1, max: 10, step: 3) // 1.0
    ///     var value5: Double = 5.0; value5.clamp(min: 1, max: 10, step: 3) // 4.0
    ///     var value6: Double = 11.0; value6.clamp(min: 1, max: 10, step: 3) // 10.0
    ///
    mutating public func clamp(
        min: Self,
        max: Self,
        step: Self? = nil
    ) {
        self = self.clamped(min: min, max: max, step: step)
    }
}

// MARK: - Number Clamped in Half-Open Range
extension FloatingPoint {
    /// Clamps value in range.
    ///
    /// Usage Example:
    ///
    ///     let value1: Double = 0.0.clamped(to: 1..<10) // 1.0
    ///     let value2: Double = 5.0.clamped(to: 1..<10) // 5.0
    ///     let value3: Double = 11.0.clamped(to: 1..<10) // 9.0
    ///
    ///     let value4: Double = 0.0.clamped(to: 1..<10, step: 3) // 1.0
    ///     let value5: Double = 5.0.clamped(to: 1..<10, step: 3) // 4.0
    ///     let value6: Double = 11.0.clamped(to: 1..<10, step: 3) // 9.0
    ///
    public func clamped(
        to range: Range<Self>,
        step: Self? = nil
    ) -> Self {
        let closedRange: ClosedRange<Self> = {
            if range.lowerBound == range.upperBound {
                return range.lowerBound...range.upperBound
            } else {
                return range.lowerBound...(range.upperBound - 1)
            }
        }()
        
        return self.clamped(to: closedRange, step: step)
    }
    
    /// Clamps value in range.
    ///
    /// Usage Example:
    ///
    ///     var value1: Double = 0.0; value1.clamp(to: 1..<10) // 1.0
    ///     var value2: Double = 5.0; value2.clamp(to: 1..<10) // 5.0
    ///     var value3: Double = 11.0; value3.clamp(to: 1..<10) // 9.0
    ///
    ///     var value4: Double = 0.0; value4.clamp(to: 1..<10, step: 3) // 1.0
    ///     var value5: Double = 5.0; value5.clamp(to: 1..<10, step: 3) // 4.0
    ///     var value6: Double = 11.0; value6.clamp(to: 1..<10, step: 3) // 9.0
    ///
    mutating public func clamp(
        to range: Range<Self>,
        step: Self? = nil
    ) {
        self = self.clamped(to: range, step: step)
    }
}
