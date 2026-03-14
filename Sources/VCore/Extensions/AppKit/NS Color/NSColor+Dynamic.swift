//
//  NSColor+Dynamic.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.01.24.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit
import OSLog

nonisolated extension NSColor {
    /// Creates `NSColor` that generates it's color data dynamically.
    ///
    ///     let color: NSColor = .dynamic(NSColor.black, NSColor.white)
    ///
    public static func dynamic(
        _ light: NSColor,
        _ dark: NSColor
    ) -> NSColor {
        .init(name: nil) { appearance in
            let resolved: NSAppearance.Name? = appearance.bestMatch(from: [.aqua, .darkAqua])
            return resolved == .darkAqua ? dark : light
        }
    }
}

#endif
