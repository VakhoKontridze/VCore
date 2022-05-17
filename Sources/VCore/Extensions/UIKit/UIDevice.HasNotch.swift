//
//  UIDevice.HasNotch.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

#if os(iOS)

import UIKit

// MARK: - Device Has Notch
extension UIDevice {
    /// Indicates if device has notch.
    ///
    /// Check is made against bottom safe are insets. If they are more than `0`, expression evaluates to`true`.
    /// The result may break with future devices.
    ///
    /// Usage Example:
    ///
    ///     let hasNotch: Bool = UIDevice.hasNotch
    ///
    public static var hasNotch: Bool {
        UIDevice.safeAreaInsetBottom > 0
    }
}

#endif
