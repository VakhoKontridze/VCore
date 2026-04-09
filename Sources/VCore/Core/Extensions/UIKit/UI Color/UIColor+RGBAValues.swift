//
//  UIColor+RGBAValues.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

#if canImport(UIKit)

import UIKit
import OSLog

nonisolated extension UIColor {
    /// Returns RGBA values of `UIColor`.
    ///
    /// `red`, `green`, and `blue` values range from `0` to `1`.
    /// `alpha` value ranges from `0` to `1`.
    ///
    ///     let (red, green, blue, alpha) = UIColor.systemBlue.rgbaValues
    ///     // (0.0, 0.4..., 1.0, 1.0)
    ///
    public var rgbaValues: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color: UIColor = {
#if !os(watchOS)
            resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
#else
            self
#endif
        }()
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        if !color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            Logger.misc.error("Failed to get RGBA values from 'UIColor' '\(self.debugDescription)'")
        }
        
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
    ///     let (red, green, blue, alpha) = UIColor.systemBlue.rgbaComponents
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
    
    /// Indicates if two `UIColor`s are RGBA equivalent.
    ///
    /// Comparison is made to each color component.
    ///
    ///     let color1: UIColor = .red
    ///     let color2: UIColor = .red
    ///     let isEqual: Bool = color1.isRGBAEqual(to: color2) // true
    ///
    public func isRGBAEqual(to otherColor: UIColor) -> Bool {
        VCore::isEqual(rgbaValues, to: otherColor.rgbaValues, by: \.red, \.green, \.blue, \.alpha)
    }
}

#endif
