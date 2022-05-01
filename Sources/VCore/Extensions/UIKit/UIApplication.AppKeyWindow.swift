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
    /// Root `UIWindow` in application.
    public var rootWindow: UIWindow? {
        if #available(iOS 15, tvOS 15, *) {
            return connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .compactMap { $0.keyWindow }
                .first
        
        } else {
            return connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first { $0 is UIWindowScene }
                .flatMap { $0 as? UIWindowScene }?
                .windows
                .first(where: \.isKeyWindow)
        }
    }
}

// MARK: - Active
extension UIApplication {
    /// Active `UIWindow` in application.
    public var activeWindow: UIWindow? {
        connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first { $0 is UIWindowScene }
            .flatMap { $0 as? UIWindowScene }?
            .windows
            .first(where: \.isKeyWindow)
    }
    
    /// Active `UIViewController` in application.
    public var activeViewController: UIViewController? {
        activeWindow?.rootViewController
    }
    
    /// Active `UIView` in application.
    public var activeView: UIView? {
        activeViewController?.view
    }
}

// MARK: - Top-Most
extension UIApplication {
    /// Top-most `UIViewController` in application.
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
    
    /// Top-most `UIView` in application.
    public var topMostView: UIView? {
        topMostViewController?.view
    }
}

#endif
