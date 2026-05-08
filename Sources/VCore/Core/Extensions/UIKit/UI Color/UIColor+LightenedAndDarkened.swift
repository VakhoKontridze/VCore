//
//  UIColor+LightenAndDarkened.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.12.24.
//

#if canImport(UIKit)

import UIKit

nonisolated extension UIColor {
    /// Returns `UIColor` lightened by a fraction.
    ///
    ///     let lightBlue: UIColor = .systemBlue.lightened(by: 0.1)
    ///
    public func lightened(
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
    
    /// Returns `UIColor` darkened by a fraction.
    ///
    ///     let darkBlue: UIColor = .systemBlue.darkened(by: 0.1)
    ///
    public func darkened(
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

#if DEBUG

import SwiftUI

#Preview {
    let color: UIColor = {
#if os(watchOS)
        UIColor.blue
#else
        UIColor.systemBlue
#endif
    }()
    
    VStack {
        Color(color.lightened(by: 0.1))
        Color(color.darkened(by: 0.1))
    }
}

#endif

#endif
