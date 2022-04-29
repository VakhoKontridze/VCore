//
//  UIWindow.SafeAreas.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.04.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Window Safe Areas
extension UIWindow {
    /// Safe area insets in root window of `UIApplication.shared`.
    public static var safeAreaInsets: UIEdgeInsets? {
        UIApplication.shared.rootWindow?.safeAreaInsets
    }
    
    /// Left safe area inset in root window of `UIApplication.shared`.
    public static var safeAreaInsetLeft: CGFloat {
        safeAreaInsets?.left ?? 0
    }

    /// Right safe area inset in root window of `UIApplication.shared`.
    public static var safeAreaInsetRight: CGFloat {
        safeAreaInsets?.right ?? 0
    }

    /// Top safe area inset in root window of `UIApplication.shared`.
    public static var safeAreaInsetTop: CGFloat {
        safeAreaInsets?.top ?? 0
    }

    /// Bottom safe area inset in root window of `UIApplication.shared`.
    public static var safeAreaInsetBottom: CGFloat {
        safeAreaInsets?.bottom ?? 0
    }
}

#endif
