//
//  UINavigationBar+Height.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Navigation Bar + Height
extension UINavigationBar {
    /// Navigation bar height.
    ///
    ///     let height: CGFloat = UINavigationBar.height
    ///
    public static var height: CGFloat {
        UINavigationController(
            rootViewController: UIViewController(nibName: nil, bundle: nil)
        )
        .navigationBar
        .frame
        .size
        .height
    }
}

#endif
