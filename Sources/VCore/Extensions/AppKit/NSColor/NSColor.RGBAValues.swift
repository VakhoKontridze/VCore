//
//  NSColor.RGBAValues.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit
import OSLog

// MARK: - RGBA Values
extension NSColor {
    /// Returns RGBA values of `NSColor`.
    ///
    /// `red`, `green`, and `blue` values range from `0` to `1`.
    /// `alpha` value ranges from `0` to `1`.
    ///
    ///     let (red, green, blue, alpha) = NSColor.systemBlue.rgbaValues
    ///     // (0.0, 0.4..., 1.0, 1.0)
    ///
    public var rgbaValues: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        guard
            let calibratedColor: NSColor = usingColorSpace(.deviceRGB)
        else {
            Logger.misc.critical("Failed to calibrate 'NSColor' '\(debugDescription)' with 'NSColorSpace.deviceRGB'")
            fatalError()
        }

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        calibratedColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (
            red: red,
            green: green,
            blue: blue,
            alpha: alpha
        )
    }
    
    /// Returns RGBA components of `UIColor`.
    ///
    /// `red`, `green`, and `blue` values range from `0` to `255`.
    /// `alpha` value ranges from `0` to `1`.
    ///
    ///     let (red, green, blue, alpha) = NSColor.systemBlue.rgbaComponents
    ///     // (0, 122, 255, 1.0)
    ///
    public var rgbaComponents: (red: Int, green: Int, blue: Int, alpha: CGFloat) {
        let values: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = rgbaValues

        let red: Int = .init(values.red * 255)
        let green: Int = .init(values.green * 255)
        let blue: Int = .init(values.blue * 255)
        let alpha: CGFloat = values.alpha
        
        return (red, green, blue, alpha)
    }
    
    /// Indicates if two `NSColor`s are RGBA equivalent.
    ///
    /// Comparison is made to each color component.
    ///
    ///     let color1: NSColor = .red
    ///     let color2: NSColor = .red
    ///     let isEqual: Bool = color1.isRGBAEqual(to: color2) // true
    ///
    public func isRGBAEqual(to otherColor: NSColor) -> Bool {
        VCore.isEqual(rgbaValues, to: otherColor.rgbaValues, by: \.red, \.green, \.blue, \.alpha)
    }
}

#endif
