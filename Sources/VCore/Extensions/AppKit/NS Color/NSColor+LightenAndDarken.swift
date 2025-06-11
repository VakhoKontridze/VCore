//
//  NSColor+LightenAndDarken.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.12.24.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

// MARK: - NS Color + Lighten and Darken
extension NSColor {
    /// Lightens `NSColor` by a fraction.
    ///
    ///     let lightBlue: NSColor = .systemBlue.lighten(by: 0.1)
    ///
    public func lighten(
        by fraction: CGFloat
    ) -> NSColor {
        let fraction: Double = fraction.clamped(to: 0...1)
        
        let values: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = rgbaValues
        
        return NSColor(
            red: (values.red + fraction).clamped(to: 0...1),
            green: (values.green + fraction).clamped(to: 0...1),
            blue: (values.blue + fraction).clamped(to: 0...1),
            alpha: values.alpha
        )
    }
    
    /// Darkens `NSColor` by a fraction.
    ///
    ///     let darkBlue: NSColor = .systemBlue.darken(by: 0.1)
    ///
    public func darken(
        by fraction: CGFloat
    ) -> NSColor {
        let fraction: Double = fraction.clamped(to: 0...1)
        
        let values: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = rgbaValues
        
        return NSColor(
            red: (values.red - fraction).clamped(to: 0...1),
            green: (values.green - fraction).clamped(to: 0...1),
            blue: (values.blue - fraction).clamped(to: 0...1),
            alpha: values.alpha
        )
    }
}

// MARK: - Preview
#if DEBUG

import SwiftUI

#Preview {
    VStack {
        Color(NSColor.systemBlue.lighten(by: 0.1))
        Color(NSColor.systemBlue.darken(by: 0.1))
    }
}

#endif

#endif

