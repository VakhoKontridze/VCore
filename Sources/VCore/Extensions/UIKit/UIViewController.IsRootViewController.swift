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
    /// Can be used to insert a subviews on `UIViewControllers`'s conditionally.
    ///
    ///     if isRootViewController == true {
    ///         addSideBarButton()
    ///     }
    ///
    public var isRootViewController: Bool? {
        guard let navigationController else { return nil }
        
        return navigationController.viewControllers.first == self
    }
    
    /// Indicates if `UIViewController` is non-`rootViewController` inside `UINavigationController`.
    ///
    /// If `UIViewController` is not embedded in `UINavigationController`, `nil` is returned.
    ///
    /// Can be used to insert a custom back button on `UIViewControllers`'s conditionally.
    ///
    ///     if isNonRootViewController == true {
    ///         addBackButton()
    ///     }
    ///
    public var isNonRootViewController: Bool? {
        guard let navigationController else { return nil }

        return navigationController.viewControllers.first != self
    }
}

#endif
