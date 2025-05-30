//
//  UIColor+LightenAndDarken.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.12.24.
//

#if canImport(UIKit)

import UIKit

// MARK: - UI Color + Lighten and Darken
extension UIColor {
    /// Lightens `UIColor` by a fraction.
    ///
    ///     let lightBlue: UIColor = .systemBlue.lighten(by: 0.1)
    ///
    public func lighten(
        by fraction: CGFloat
    ) -> UIColor {
        let fraction: Double = fraction.clamped(to: 0...1)
        
        let values: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = rgbaValues
        
        return UIColor(
            red: (values.red + fraction).clamped(to: 0...1),
            green: (values.green + fraction).clamped(to: 0...1),
            blue: (values.blue + fraction).clamped(to: 0...1),
            alpha: values.alpha
        )
    }
    
    /// Darkens `UIColor` by a fraction.
    ///
    ///     let darkBlue: UIColor = .systemBlue.darken(by: 0.1)
    ///
    public func darken(
        by fraction: CGFloat
    ) -> UIColor {
        let fraction: Double = fraction.clamped(to: 0...1)
        
        let values: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = rgbaValues
        
        return UIColor(
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

#Preview(body: {
    let color: UIColor = {
#if os(watchOS)
        UIColor.blue
#else
        UIColor.systemBlue
#endif
    }()
    
    VStack(content: {
        Color(color.lighten(by: 0.1))
        Color(color.darken(by: 0.1))
    })
})

#endif

#endif

