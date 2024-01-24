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
    /// Creates `UIColor` that generates it's color data dynamically.
    ///
    ///     let accentColor: Color = .dynamic(light: ..., dark: ...)
    ///
    public static func dynamic(
        light: Color,
        dark: Color
    ) -> Self {
#if canImport(UIKit)
        .init(
            uiColor: UIColor.dynamic(
                light: UIColor(light),
                dark: UIColor(dark)
            )
        )
#elseif canImport(AppKit)
        .init(
            nsColor: NSColor.dynamic(
                light: NSColor(light),
                dark: NSColor(dark)
            )
        )
#endif
    }
}
