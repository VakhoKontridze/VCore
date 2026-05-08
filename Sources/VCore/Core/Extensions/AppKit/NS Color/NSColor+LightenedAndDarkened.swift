//
//  NSColor+LightenedAndDarkened.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.12.24.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

nonisolated extension NSColor {
    /// Returns `NSColor` lightened by a fraction.
    ///
    ///     let lightBlue: NSColor = .systemBlue.lightened(by: 0.1)
    ///
    public func lightened(
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
    
    /// Returns `NSColor` darkened by a fraction.
    ///
    ///     let darkBlue: NSColor = .systemBlue.darkened(by: 0.1)
    ///
    public func darkened(
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

#if DEBUG

import SwiftUI

#Preview {
    VStack {
        Color(NSColor.systemBlue.lightened(by: 0.1))
        Color(NSColor.systemBlue.darkened(by: 0.1))
    }
}

#endif

#endif
