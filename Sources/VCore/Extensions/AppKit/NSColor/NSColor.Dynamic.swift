//
//  NSColor.Dynamic.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.01.24.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

// MARK: - Color Dynamic
extension NSColor {
    /// Creates `NSColor` that generates it's color data dynamically.
    ///
    ///     let accentColor: NSColor = .dynamic(light: ..., dark: ...)
    ///
    public static func dynamic(
        light: NSColor,
        dark: NSColor
    ) -> NSColor {
        .init(
            name: nil,
            dynamicProvider: { appearance in
                switch appearance.name {
                case .aqua: light
                case .accessibilityHighContrastAqua: light
                case .accessibilityHighContrastVibrantLight: light

                case .darkAqua: dark
                case .vibrantDark: dark
                case .accessibilityHighContrastDarkAqua: dark
                case .accessibilityHighContrastVibrantDark: dark

                default: light
                }
            }
        )
    }
}

#endif
