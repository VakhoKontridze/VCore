//
//  UIApplication+TopMostViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.03.23.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Application + Top-Most ViewController
extension UIApplication {
    /// Returns top-most `UIViewController` in an `UIWindow`.
    public func topMostViewController(
        inWindow window: UIWindow
    ) -> UIViewController? {
        guard
            var topMostViewController: UIViewController = window.rootViewController
        else {
            return nil
        }
        
        while let presentedViewController = topMostViewController.presentedViewController {
            topMostViewController = presentedViewController
        }
        
        return topMostViewController
    }
}

#endif
