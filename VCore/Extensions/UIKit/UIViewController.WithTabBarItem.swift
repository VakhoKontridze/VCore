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
    public func withTabBarItem(_ tabBarItem: UITabBarItem) -> UIViewController {
        self.tabBarItem = tabBarItem
        return self
    }
}
