//
//  UIApplication.AppKeyWindow.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/14/22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Root
extension UIApplication {
    /// Returns root `UIWindow` in application.
    ///
    ///     let rootWindow: UIWindow? = UIApplication.shared.rootWindow
    ///
    public var rootWindow: UIWindow? {
        if #available(iOS 15, tvOS 15, *) {
            return connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .compactMap { $0.keyWindow ?? $0.windows.first }
                .first
        
        } else {
            return connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first { $0 is UIWindowScene }
                .flatMap { $0 as? UIWindowScene }?
                .windows
                .first(where: { $0.isKeyWindow })
        }
    }
    
    /// Returns root `UIViewController` in application.
    ///
    ///     let rootViewController: UIViewController? = UIApplication.shared.rootViewController
    public var rootViewController: UIViewController? {
        rootWindow?.rootViewController
    }
    
    /// Returns root `UIView` in application.
    ///
    ///     let rootView: UIView? = UIApplication.shared.rootView
    public var rootView: UIView? {
        rootViewController?.view
    }
}

// MARK: - Active
extension UIApplication {
    /// Returns active `UIWindow` in application.
    ///
    ///     let activeWindow: UIWindow? = UIApplication.shared.activeWindow
    ///
    public var activeWindow: UIWindow? {
        connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first { $0 is UIWindowScene }
            .flatMap { $0 as? UIWindowScene }?
            .windows
            .first(where: { $0.isKeyWindow })
    }
    
    /// Returns active `UIViewController` in application.
    ///
    ///     let activeViewController: UIViewController? = UIApplication.shared.activeViewController
    ///
    public var activeViewController: UIViewController? {
        activeWindow?.rootViewController
    }
    
    /// Returns active `UIView` in application.
    ///
    ///     let activeView: UIView? = UIApplication.shared.activeView
    ///
    public var activeView: UIView? {
        activeViewController?.view
    }
}

// MARK: - Top-Most
extension UIApplication {
    /// Returns top-most `UIViewController` in application.
    ///
    ///     let topMostViewController: UIViewController? = UIApplication.shared.topMostViewController
    ///
    public var topMostViewController: UIViewController? {
        guard
            let activeWindow = activeWindow,
            var topMostViewController: UIViewController = activeWindow.rootViewController
        else {
            return nil
        }

        while let presentedViewController = topMostViewController.presentedViewController {
            topMostViewController = presentedViewController
        }

        return topMostViewController
    }
    
    /// Returns top-most `UIView` in application.
    ///
    ///     let topMostView: UIView? = UIApplication.shared.topMostView
    ///
    public var topMostView: UIView? {
        topMostViewController?.view
    }
}

#endif
