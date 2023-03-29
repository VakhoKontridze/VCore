//
//  NSColor.Blend.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

#if canImport(AppKit)

import AppKit

// MARK: - Blend Color
extension NSColor {
    /// Blends two `NSColor`s together.
    ///
    ///     let purple: NSColor = .blend(.red, with: .blue)
    ///
    public static func blend(
        _ color1: NSColor,
        ratio1: CGFloat = 0.5,
        with color2: NSColor,
        ratio2: CGFloat = 0.5
    ) -> NSColor {
        let weight1: CGFloat = ratio1 / (ratio1 + ratio2)
        let weight2: CGFloat = ratio2 / (ratio1 + ratio2)
        
        guard weight1 > 0 else { return color2 }
        guard weight2 > 0 else { return color1 }
        
        let values1: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = color1.rgbaValues
        let values2: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = color2.rgbaValues
        
        return NSColor(
            red: weight1 * values1.red + weight2 * values2.red,
            green: weight1 * values1.green + weight2 * values2.green,
            blue: weight1 * values1.blue + weight2 * values2.blue,
            alpha: weight1 * values1.alpha + weight2 * values2.alpha
        )
    }
    
    /// Lightens `NSColor` by value.
    ///
    /// `value` ranges from `0` to `1`.
    ///
    ///     let lightBlue: NSColor = .systemBlue.lighten(by: 0.1)
    ///
    public func lighten(by value: CGFloat) -> NSColor {
        let values: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = rgbaValues
        
        return NSColor(
            red: (values.red + value).clamped(to: 0...1),
            green: (values.green + value).clamped(to: 0...1),
            blue: (values.blue + value).clamped(to: 0...1),
            alpha: values.alpha
        )
    }
    
    /// Darkens `NSColor` by value.
    ///
    /// `value` ranges from `0` to `1`
    ///
    ///     let darkBlue: NSColor = .systemBlue.darken(by: 0.1)
    ///
    public func darken(by value: CGFloat) -> NSColor {
        let values: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = rgbaValues
        
        return NSColor(
            red: (values.red - value).clamped(to: 0...1),
            green: (values.green - value).clamped(to: 0...1),
            blue: (values.blue - value).clamped(to: 0...1),
            alpha: values.alpha
        )
    }
}

#endif

