//
//  Color.Blend.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

import SwiftUI

// MARK: - Blend Color
@available(iOS 15.0, *)
@available(macOS 12.0, *)
@available(tvOS 15.0, *)
@available(watchOS 8.0, *)
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
        
        return .init(uiColor: UIColor.blend(
            .init(color1),
            ratio1: ratio1,
            with: .init(color2),
            ratio2: ratio2
        ))
        
        #elseif canImport(AppKit)
        
        return .init(nsColor: NSColor.blend(
            .init(color1).calibrated,
            ratio1: ratio1,
            with: .init(color2).calibrated,
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
        return .init(uiColor: UIColor(self).lighten(by: value))
        #elseif canImport(AppKit)
        return .init(nsColor: NSColor(self).calibrated.lighten(by: value))
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
        return .init(uiColor: UIColor(self).darken(by: value))
        #elseif canImport(AppKit)
        return .init(nsColor: NSColor(self).calibrated.darken(by: value))
        #endif
    }
}
