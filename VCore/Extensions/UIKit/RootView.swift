//
//  RootView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import UIKit

// MARK:- App Root View
extension UIScreen {
    /// Root view of the app
    ///
    /// - Root View Controller must be loaded on screen for this property to return a non-`nil` value
    public static var rootView: UIView? {
        guard
            let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
            let view = window.rootViewController
        else {
            return nil
        }
        
        switch view {
        case let tabBarController as UITabBarController: return tabBarController.view
        case let navigationController as UINavigationController: return navigationController.view
        case let viewController: return viewController.view
        }
    }
}
