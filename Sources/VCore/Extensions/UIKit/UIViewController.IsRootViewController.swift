//
//  UIViewController.IsRootViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - View Controller Is Root View Controller
extension UIViewController {
    /// Indicates if `UIViewController` is `rootViewController` inside `UINavigationController`.
    ///
    /// If `UIViewController` is not embedded in `UINavigationController`, `nil` is returned.
    ///
    ///     let isRootViewController: UIViewController = viewController.isRootViewController
    ///
    public var isRootViewController: Bool? {
        guard let navigationController = navigationController else { return nil }
        
        return navigationController.viewControllers.first == self
    }
    
    /// Indicates if `UIViewController` is non-`rootViewController` inside `UINavigationController`.
    ///
    /// If `UIViewController` is not embedded in `UINavigationController`, `nil` is returned.
    ///
    ///     let isNonRootViewController: UIViewController = viewController.isNonRootViewController
    ///
    public var isNonRootViewController: Bool? {
        guard let navigationController = navigationController else { return nil }

        return navigationController.viewControllers.first != self
    }
}

#endif
