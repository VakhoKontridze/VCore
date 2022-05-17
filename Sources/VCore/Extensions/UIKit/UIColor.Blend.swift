//
//  UIColor.Blend.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

#if canImport(UIKit)

import UIKit

// MARK: - Blend Color
extension UIColor {
    /// Blends two colors together.
    ///
    /// Usage Example:
    ///
    ///     let purple: UIColor = .blend(.red, with: .blue)
    ///
    public static func blend(
        _ color1: UIColor,
        ratio1: CGFloat = 0.5,
        with color2: UIColor,
        ratio2: CGFloat = 0.5
    ) -> UIColor {
        let weight1: CGFloat = ratio1 / (ratio1 + ratio2)
        let weight2: CGFloat = ratio2 / (ratio1 + ratio2)
        
        guard weight1 > 0 else { return color2 }
        guard weight2 > 0 else { return color1 }
        
        let values1: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = color1.rgbaValues
        let values2: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = color2.rgbaValues
        
        return .init(
            red: weight1 * values1.red + weight2 * values2.red,
            green: weight1 * values1.green + weight2 * values2.green,
            blue: weight1 * values1.blue + weight2 * values2.blue,
            alpha: weight1 * values1.alpha + weight2 * values2.alpha
        )
    }
    
    /// Lightens `UIColor` by value.
    ///
    /// `value` ranges from `0` to `1`.
    ///
    /// Usage Example:
    ///
    ///     let lightBlue: UIColor = .systemBlue.lighten(by: 0.1)
    ///
    public func lighten(by value: CGFloat) -> UIColor {
        let values: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = rgbaValues
        
        return .init(
            red: (values.red + value).clamped(to: 0...1),
            green: (values.green + value).clamped(to: 0...1),
            blue: (values.blue + value).clamped(to: 0...1),
            alpha: values.alpha
        )
    }
    
    /// Darkens `UIColor` by value.
    ///
    /// `value` ranges from `0` to `1`
    ///
    /// Usage Example:
    ///
    ///     let darkBlue: UIColor = .systemBlue.darken(by: 0.1)
    ///
    public func darken(by value: CGFloat) -> UIColor {
        let values: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = rgbaValues
        
        return .init(
            red: (values.red - value).clamped(to: 0...1),
            green: (values.green - value).clamped(to: 0...1),
            blue: (values.blue - value).clamped(to: 0...1),
            alpha: values.alpha
        )
    }
}

#endif
