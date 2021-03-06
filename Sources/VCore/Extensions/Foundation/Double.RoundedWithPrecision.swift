//
//  Double.RoundedWithPrecision.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

import Foundation

// MARK: - Double Rounded to Precision
extension Double {
    /// Rounds `Double` with precision.
    ///
    ///     let rounded1: Double = 3.1415.rounded(fractions: 2) // 3.14
    ///
    ///     let rounded2: Double = 3.1415.rounded(fractions: 3) // 3.142
    ///
    public func rounded(fractions: Int) -> Double {
        assert(fractions >= 0)
        
        let power: Double = pow(10, .init(fractions))
        return (self * power).rounded() / power
    }
    
    /// Returns `Double` rounded with precision.
    ///
    ///     var num1: Double = 3.1415
    ///     num1.round(fractions: 2) // 3.14
    ///
    ///     var num2: Double = 3.1415
    ///     num2.round(fractions: 3) // 3.142
    ///
    mutating public func round(fractions: Int) {
        self = self.rounded(fractions: fractions)
    }
}
