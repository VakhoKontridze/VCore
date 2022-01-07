//
//  UIViewController.WithTabBarItem.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/9/21.
//

import UIKit

// MARK: - View Controller with Tab Bar Item
extension UIViewController {
    /// Adds `UITabBarItem` to `UIViewController` and returns it.
    ///
    /// Usage Example:
    ///
    ///     let tabBarController: UITabBarController = .init()
    ///
    ///     tabBarController.viewControllers = [
    ///         HomeViewController().withTabBarItem(.init(title: "Home", image: nil, tag: 1))
    ///     ]
    ///     
    public func withTabBarItem(_ tabBarItem: UITabBarItem) -> UIViewController {
        self.tabBarItem = tabBarItem
        return self
    }
}
