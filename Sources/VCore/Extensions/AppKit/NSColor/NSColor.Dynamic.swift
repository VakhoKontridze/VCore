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
                case .aqua: return light
                case .accessibilityHighContrastAqua: return light
                case .accessibilityHighContrastVibrantLight: return light

                case .darkAqua: return dark
                case .vibrantDark: return dark
                case .accessibilityHighContrastDarkAqua: return dark
                case .accessibilityHighContrastVibrantDark: return dark

                default:
                    VCoreLogWarning("Unhandled case in 'NSColor.dynamic(light:dark:)'")
                    return light
                }
            }
        )
    }
}

#endif
