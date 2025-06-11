//
//  NSColor+Dynamic.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.01.24.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit
import OSLog

// MARK: - NS Color + Dynamic
extension NSColor {
    /// Creates `NSColor` that generates it's color data dynamically.
    ///
    ///     let color: NSColor = .dynamic(NSColor.black, NSColor.white)
    ///
    public static func dynamic(
        _ light: NSColor,
        _ dark: NSColor
    ) -> NSColor {
        .init(name: nil) { appearance in
            switch appearance.name {
            case .aqua: return light
            case .accessibilityHighContrastAqua: return light
            case .accessibilityHighContrastVibrantLight: return light

            case .darkAqua: return dark
            case .vibrantDark: return dark
            case .accessibilityHighContrastDarkAqua: return dark
            case .accessibilityHighContrastVibrantDark: return dark

            default:
                Logger.misc.fault("Unhandled 'NSAppearance' '\(appearance.debugDescription)' in 'NSColor.dynamic(_:_:)'")
                return light
            }
        }
    }
}

#endif
