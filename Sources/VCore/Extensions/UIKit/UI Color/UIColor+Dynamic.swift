//
//  UIColor+Dynamic.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.01.24.
//

#if canImport(UIKit)

import UIKit
import OSLog

// MARK: - UI Color + Dynamic
@available(watchOS, unavailable) // Light/dark mode and `UIColor(dynamicProvider:)` API do not exist. OS selects light color from the assets catalogue.
@available(visionOS, unavailable) // Light/dark mode do not exist. OS selects dark color from the assets catalogue.
extension UIColor {
    /// Creates `UIColor` that generates it's color data dynamically.
    ///
    ///     let color: UIColor = .dynamic(UIColor.black, UIColor.white)
    ///
    public static func dynamic(
        _ light: UIColor,
        _ dark: UIColor
    ) -> UIColor {
#if os(watchOS)
        fatalError() // Not supported
#else
        UIColor(
            dynamicProvider: { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .unspecified: return light
                case .light: return light
                case .dark: return dark
                @unknown default:
                    Logger.misc.fault("Unhandled 'UIUserInterfaceStyle' '\(String(describing: traitCollection.userInterfaceStyle))' in 'UIColor.dynamic(_:_:)'")
                    return light
                }
            }
        )
#endif
    }
}

#endif
