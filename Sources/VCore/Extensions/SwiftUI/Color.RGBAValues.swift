//
//  Color.RGBAValues.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

import SwiftUI

// MARK: - RGBA Values
@available(iOS 14.0, *)
@available(macOS 11.0, *)
@available(tvOS 14.0, *)
@available(watchOS 7.0, *)
extension Color {
    /// Returns RGBA values of `Color`.
    ///
    /// `red`, `green`, and `blue` values range from `0` to `1`.
    /// `alpha` value ranges from `0` to `1`.
    ///
    ///     let (red, green, blue, alpha) = Color.blue.rgbaValues
    ///     // (0.0, 0.4..., 1.0, 1.0)
    ///
    public var rgbaValues: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        #if canImport(UIKit)
        return UIColor(self).rgbaValues
        #elseif canImport(AppKit)
        return NSColor(self).rgbaValues
        #endif
    }
    
    /// Returns RGBA components of `Color`.
    ///
    /// `red`, `green`, and `blue` values range from `0` to `255`.
    /// `alpha` value ranges from `0` to `1`.
    ///
    ///     let (red, green, blue, alpha) = Color.blue.rgbaComponents
    ///     // (0, 122, 255, 1.0)
    ///
    public var rgbaComponents: (red: Int, green: Int, blue: Int, alpha: CGFloat) {
        #if canImport(UIKit)
        return UIColor(self).rgbaComponents
        #elseif canImport(AppKit)
        return NSColor(self).rgbaComponents
        #endif
    }
    
    /// Indicates if two `Color`'s are RGBA equivalent.
    ///
    /// Comparison is made to each color component.
    ///
    ///     let color1: UIColor = .red
    ///     let color2: UIColor = .red
    ///     let isEqual: Bool = color1.isRGBAEqual(to: color2) // true
    ///
    public func isRGBAEqual(to otherColor: Color) -> Bool {
        #if canImport(UIKit)
        return UIColor(self).isRGBAEqual(to: .init(otherColor))
        #elseif canImport(AppKit)
        return NSColor(self).isRGBAEqual(to: .init(otherColor))
        #endif
    }
}
