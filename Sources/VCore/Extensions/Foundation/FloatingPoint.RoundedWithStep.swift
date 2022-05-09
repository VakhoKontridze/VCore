//
//  FloatingPoint.RoundedWithStep.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 1/7/22.
//

import Foundation

// MARK: - Number Rounded with Step
extension FloatingPoint {
    /// Returns value rounded to a floating point in a range with a given step.
    ///
    /// Usage Example:
    ///
    ///     let value1: Double = 0.0.rounded(range: 1...10, step: 3) // 1.0
    ///     let value2: Double = 5.0.rounded(range: 1...10, step: 3) // 4.0
    ///     let value3: Double = 10.0.rounded(range: 1...10, step: 3) // 10.0
    ///
    public func rounded(
        range: ClosedRange<Self>,
        step: Self
    ) -> Self {
        range.lowerBound + ((self - range.lowerBound) / step).rounded() * step
    }
    
    /// Rounds value to a floating point in a range with a given step.
    ///
    /// Usage Example:
    ///
    ///     var value1: Double = 0.0
    ///     var value2: Double = 5.0
    ///     var value3: Double = 10.0
    ///
    ///     value1.round(range: 1...10, step: 3) // 1.0
    ///     value2.round(range: 1...10, step: 3) // 4.0
    ///     value3.round(range: 1...10, step: 3) // 10.0
    ///
    mutating public func round(
        range: ClosedRange<Self>,
        step: Self
    ) {
        self = self.rounded(range: range, step: step)
    }
}
