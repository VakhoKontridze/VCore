//
//  Color.Dynamic.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.01.24.
//

import SwiftUI

// MARK: - Color Dynamic
@available(watchOS, unavailable) // Light/dark mode and `UIColor(dynamicProvider:)` API do not exist. OS selects light color from the assets catalogue.
@available(visionOS, unavailable) // Light/dark mode do not exist. OS selects dark color from the assets catalogue.
extension Color {
    /// Creates `Color` that generates it's color data dynamically.
    ///
    ///     let color: Color = .dynamic(Color.black, Color.white)
    ///
    public static func dynamic(
        _ light: Color,
        _ dark: Color
    ) -> Self {
#if canImport(UIKit)
        Color(
            uiColor: UIColor.dynamic(UIColor(light), UIColor(dark))
        )
#elseif canImport(AppKit)
        Color(
            nsColor: NSColor.dynamic(NSColor(light), NSColor(dark))
        )
#endif
    }
}
