//
//  Color.Blend.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

import SwiftUI

// MARK: - Color Blend
extension Color {
    /// Blends two `Color`s together.
    ///
    ///     let purple: Color = .blend(.red, with: .blue)
    ///
    public static func blend(
        _ color1: Color,
        ratio1: CGFloat = 0.5,
        with color2: Color,
        ratio2: CGFloat = 0.5
    ) -> Color {
#if canImport(UIKit)
        return Color(uiColor: UIColor.blend(
            UIColor(color1),
            ratio1: ratio1,
            with: UIColor(color2),
            ratio2: ratio2
        ))
#elseif canImport(AppKit)
        return Color(nsColor: NSColor.blend(
            NSColor(color1).calibrated,
            ratio1: ratio1,
            with: NSColor(color2).calibrated,
            ratio2: ratio2
        ))
#endif
    }
    
    /// Lightens `Color` by value.
    ///
    /// `value` ranges from `0` to `1`.
    ///
    ///     let lightBlue: Color = .systemBlue.lighten(by: 0.1)
    ///
    public func lighten(by value: CGFloat) -> Color {
#if canImport(UIKit)
        return Color(uiColor: UIColor(self).lighten(by: value))
#elseif canImport(AppKit)
        return Color(nsColor: NSColor(self).calibrated.lighten(by: value))
#endif
    }
    
    /// Darkens `Color` by value.
    ///
    /// `value` ranges from `0` to `1`
    ///
    ///     let darkBlue: Color = .systemBlue.darken(by: 0.1)
    ///
    public func darken(by value: CGFloat) -> Color {
#if canImport(UIKit)
        return Color(uiColor: UIColor(self).darken(by: value))
#elseif canImport(AppKit)
        return Color(nsColor: NSColor(self).calibrated.darken(by: value))
#endif
    }
}
