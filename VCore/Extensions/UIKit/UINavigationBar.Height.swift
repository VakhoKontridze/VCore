//
//  UINavigationBar.Height.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import UIKit

// MARK: - Navigation Bar Height
extension UINavigationBar {
    /// Navigation bar height.
    ///
    /// Usage Example:
    ///
    ///     let height: CGFloat = UINavigationBar.height // 44.0
    ///     
    public static var height: CGFloat {
        UINavigationController(rootViewController: .init(nibName: nil, bundle: nil))
            .navigationBar
            .frame
            .size
            .height
    }
}
