//
//  UIColor.Dynamic.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.01.24.
//

#if canImport(UIKit)

import UIKit
import OSLog

// MARK: - Color Dynamic
@available(watchOS, unavailable) // Light/dark mode and `UIColor(dynamicProvider:)` API do not exist. OS selects light color from the assets catalogue.
@available(visionOS, unavailable) // Light/dark mode do not exist. OS selects dark color from the assets catalogue.
extension UIColor {
    /// Creates `UIColor` that generates it's color data dynamically.
    ///
    ///     let accentColor: UIColor = .dynamic(light: ..., dark: ...)
    ///
    public static func dynamic(
        light: UIColor,
        dark: UIColor
    ) -> UIColor {
#if os(watchOS)
        fatalError()
#else
        .init(
            dynamicProvider: { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .unspecified: return light
                case .light: return light
                case .dark: return dark
                @unknown default:
                    Logger.misc.fault("Unhandled case in 'UIColor.dynamic(light:dark:)'")
                    return light
                }
            }
        )
#endif
    }
}

#endif
