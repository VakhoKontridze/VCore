//
//  UIApplication+TopmostViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.03.23.
//

#if canImport(UIKit) && !os(watchOS)

public import UIKit

extension UIApplication {
    /// Returns topmost `UIViewController` in a `UIWindow`.
    ///
    /// `UIViewController` that is being dismissed is skipped, as a `UIViewController` presented from it is never shown.
    /// This happens when a modal is presented while the previous one is still being dismissed.
    public func topmostViewController(
        inWindow window: UIWindow
    ) -> UIViewController? {
        guard
            var topmostViewController: UIViewController = window.rootViewController
        else {
            return nil
        }
        
        while
            let presentedViewController: UIViewController = topmostViewController.presentedViewController,
            !presentedViewController.isBeingDismissed
        {
            topmostViewController = presentedViewController
        }
        
        return topmostViewController
    }
}

#endif
