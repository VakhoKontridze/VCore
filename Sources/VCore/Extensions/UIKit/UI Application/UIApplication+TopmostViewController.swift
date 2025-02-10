//
//  UIApplication+TopmostViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.03.23.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Application + Topmost ViewController
extension UIApplication {
    /// Returns topmost `UIViewController` in a `UIWindow`.
    public func topmostViewController(
        inWindow window: UIWindow
    ) -> UIViewController? {
        guard
            var topmostViewController: UIViewController = window.rootViewController
        else {
            return nil
        }
        
        while let presentedViewController = topmostViewController.presentedViewController {
            topmostViewController = presentedViewController
        }
        
        return topmostViewController
    }
}

#endif
