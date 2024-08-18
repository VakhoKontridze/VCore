//
//  Double+RoundedWithPrecision.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

import Foundation
import OSLog

// MARK: - Double + Rounded to Precision
extension Double {
    /// Rounds `Double` with precision.
    ///
    ///     let rounded1: Double = 3.1415.rounded(fractions: 2) // 3.14
    ///
    ///     let rounded2: Double = 3.1415.rounded(fractions: 3) // 3.142
    ///
    public func rounded(fractions: Int) -> Double {
        guard fractions >= 0 else {
            Logger.misc.critical("'fractions' must be greater than or equal to '0' in 'Double.rounded(fractions:)'")
            fatalError()
        }
        
        let power: Double = pow(10, Double(fractions))
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
        self = rounded(fractions: fractions)
    }
}
