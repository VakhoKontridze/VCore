//
//  FloatingPoint.FixedInRange.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/9/21.
//

import Foundation

// MARK: - Number Fixed in Range
extension FloatingPoint {
    /// Combination of `min` and `max` function that returns a number fixed in a given range.
    ///
    /// Usage Example:
    ///
    ///     let value1: Double = 0.0.fixedInRange(1...10) // 1.0
    ///     let value2: Double = 5.0.fixedInRange(1...10) // 5.0
    ///     let value3: Double = 11.0.fixedInRange(1...10) // 10.0
    ///
    ///     let value4: Double = 0.0.fixedInRange(1...10, step: 3) // 1.0
    ///     let value5: Double = 5.0.fixedInRange(1...10, step: 3) // 4.0
    ///     let value6: Double = 11.0.fixedInRange(1...10, step: 3) // 10.0
    ///
    public func fixedInRange(
        _ range: ClosedRange<Self>,
        step: Self? = nil
    ) -> Self {
        switch (self, step) {
        case (...range.lowerBound, _): return range.lowerBound
        case (range.upperBound..., _): return range.upperBound
        case (_, nil): return self
        case (_, let step?): return self.roundedWithStep(range, step: step)
        }
    }
    
    /// Combination of `min` and `max` function that returns a number fixed in a given range.
    ///
    /// Usage Example:
    ///
    ///     let value1: Double = 0.0.fixedInRange(min: 1, max: 10) // 1.0
    ///     let value2: Double = 5.0.fixedInRange(min: 1, max: 10) // 5.0
    ///     let value3: Double = 11.0.fixedInRange(min: 1, max: 10) // 10.0
    ///
    ///     let value4: Double = 0.0.fixedInRange(min: 1, max: 10, step: 3) // 1.0
    ///     let value5: Double = 5.0.fixedInRange(min: 1, max: 10, step: 3) // 4.0
    ///     let value6: Double = 11.0.fixedInRange(min: 1, max: 10, step: 3) // 10.0
    ///
    public func fixedInRange(
        min: Self,
        max: Self,
        step: Self? = nil
    ) -> Self {
        fixedInRange(min...max, step: step)
    }
    
    private func roundedWithStep(
        _ range: ClosedRange<Self>,
        step: Self
    ) -> Self {
        let rawValue: Self = {
            let low: Self = floor(self / step) * step
            let high: Self = ceil(self / step) * step
            
            let lowDiff: Self = abs(self - low)
            let highDiff: Self = abs(self - high)
            
            return highDiff > lowDiff ? low : high
        }()
        
        switch rawValue {
        case ...range.lowerBound: return range.lowerBound
        case range.upperBound...: return range.upperBound
        case _: return rawValue
        }
    }
}
