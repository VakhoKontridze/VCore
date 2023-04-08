//
//  UIDevice.SafeAreas.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.04.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Device Safe Areas
extension UIDevice {
    /// Safe area insets in `UIApplication.shared.firstWindowInSingleSceneApp`.
    ///
    ///     let insets: UIEdgeInsets? = UIDevice.safeAreaInsets
    ///
    public static var safeAreaInsets: UIEdgeInsets? {
        UIApplication.shared.firstWindowInSingleSceneApp?.safeAreaInsets
    }
    
    /// Left safe area inset in `UIApplication.shared.firstWindowInSingleSceneApp`.
    ///
    ///     let inset: CGFloat = UIDevice.safeAreaInsetLeft
    ///
    public static var safeAreaInsetLeft: CGFloat {
        safeAreaInsets?.left ?? 0
    }
    
    /// Right safe area inset in `UIApplication.shared.firstWindowInSingleSceneApp`.
    ///
    ///     let inset: CGFloat = UIDevice.safeAreaInsetRight
    ///
    public static var safeAreaInsetRight: CGFloat {
        safeAreaInsets?.right ?? 0
    }
    
    /// Top safe area inset in `UIApplication.shared.firstWindowInSingleSceneApp`.
    ///
    ///     let inset: CGFloat = UIDevice.safeAreaInsetTop
    ///
    public static var safeAreaInsetTop: CGFloat {
        safeAreaInsets?.top ?? 0
    }
    
    /// Bottom safe area inset in `UIApplication.shared.firstWindowInSingleSceneApp`.
    ///
    ///     let inset: CGFloat = UIDevice.safeAreaInsetBottom
    ///
    public static var safeAreaInsetBottom: CGFloat {
        safeAreaInsets?.bottom ?? 0
    }
}

#endif
