//
//  UIDevice.SafeAreaInsets.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.04.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Device Safe Areas
extension UIDevice {
    /// Safe area insets in `UIApplication.shared.firstWindowInSingleSceneApp`.
    ///
    ///     let insets: UIEdgeInsets = UIDevice.safeAreaInsets
    ///
    public static var safeAreaInsets: UIEdgeInsets {
        UIApplication.shared.firstWindowInSingleSceneApp?.safeAreaInsets ?? .zero
    }
}

#endif
