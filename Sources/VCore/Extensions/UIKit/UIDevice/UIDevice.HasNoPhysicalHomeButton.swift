//
//  UIDevice.HasNoPhysicalHomeButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Device Has No Physical Home Button
@available(tvOS, unavailable)
extension UIDevice {
    /// Indicates if device has no physical home button.
    ///
    /// Check is made against bottom safe are inset. If they are more than `0`, expression evaluates to`true`.
    ///
    ///     let hasNoPhysicalHomeButton: Bool = UIDevice.hasNoPhysicalHomeButton
    ///
    public static var hasNoPhysicalHomeButton: Bool {
        UIDevice.safeAreaInsets.bottom > 0
    }
}

#endif
