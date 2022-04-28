//
//  UIApplication.AppKeyWindow.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/14/22.
//

import UIKit

// MARK: - App Key Window
extension UIApplication {
    /// Active `UIWindow` in applicaiton.
    public static var appKeyWindow: UIWindow? {
        UIApplication.shared
            .connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first { $0 is UIWindowScene }
            .flatMap { $0 as? UIWindowScene }?
            .windows
            .first(where: \.isKeyWindow)
    }
    
    /// Top-most `UIViewController` in applicaiton.
    static var topMostViewController: UIViewController? {
        guard
            let keyWindow = appKeyWindow,
            var topMostViewController: UIViewController = keyWindow.rootViewController
        else {
            return nil
        }

        while let presentedViewController = topMostViewController.presentedViewController {
            topMostViewController = presentedViewController
        }

        return topMostViewController
    }
    
    /// Root `UIViewController` of active `UIWindow` in application.
    public static var appRootViewController: UIViewController? {
        appKeyWindow?.rootViewController
    }
    
    /// Root `UIView` of active `UIWindow` in application.
    public static var appRootView: UIView? {
        appRootViewController?.view
    }
}
