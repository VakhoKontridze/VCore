//
//  UIColor.RGBAComponents.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

#if canImport(UIKit)

import UIKit

// MARK: - RGBA Components
extension UIColor {
    /// RGBA values of `UIColor`.
    ///
    /// `red`, `green`, and `blue` values range from `0` to `1`.
    /// `alpha` value ranges from `0` to `1`.
    ///
    /// Usage Example:
    ///
    ///     let (red, green, blue, alpha) = UIColor.systemBlue.rgbaValues
    ///     // (0.0, 0.4..., 1.0, 1.0)
    ///
    public var rgbaValues: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (
            red: red,
            green: green,
            blue: blue,
            alpha: alpha
        )
    }
    
    /// RGBA components of `UIColor`.
    ///
    /// `red`, `green`, and `blue` values range from `0` to `255`.
    /// `alpha` value ranges from `0` to `1`.
    ///
    /// Usage Example:
    ///
    ///     let (red, green, blue, alpha) = UIColor.systemBlue.rgbaComponents
    ///     // (0, 122, 255, 1.0)
    ///
    public var rgbaComponents: (red: Int, green: Int, blue: Int, alpha: CGFloat) {
        let values: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = rgbaValues
        
        return (
            red: .init(values.red * 255),
            green: .init(values.green * 255),
            blue: .init(values.blue * 255),
            alpha: values.alpha
        )
    }
}

#endif