//
//  UIColor+Mix.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

#if canImport(UIKit)

import UIKit

// MARK: - UI Color + Mix
extension UIColor {
    /// Mixes two `UIColor`s together.
    ///
    ///     let purple: UIColor = .red.mix(with: .blue, by: 0.5)
    ///
    public func mix(
        with otherColor: UIColor,
        by fraction: Double
    ) -> UIColor {
        let fraction: Double = fraction.clamped(to: 0...1)
        let otherFraction: Double = 1 - fraction
        
        let values1: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = rgbaValues
        let values2: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = otherColor.rgbaValues
        
        return UIColor(
            red: fraction * values1.red + otherFraction * values2.red,
            green: fraction * values1.green + otherFraction * values2.green,
            blue: fraction * values1.blue + otherFraction * values2.blue,
            alpha: fraction * values1.alpha + otherFraction * values2.alpha
        )
    }
}

// MARK: - Preview
#if DEBUG

import SwiftUI

#Preview(body: {
    Color(UIColor.red.mix(with: .blue, by: 0.5))
})

#endif

#endif
