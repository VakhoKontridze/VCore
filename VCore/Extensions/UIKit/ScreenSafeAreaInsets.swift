//
//  ScreenSafeAreaInsets.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import UIKit

// MARK:- Safe Area Heights
extension UIScreen {
    /// Object containing information about screen's safe area edge insets
    ///
    /// - Root View Controller must be loaded on screen for this property to return a non-`nil` value
    public static var safeAreaInsets: UIEdgeInsets? {
        rootView?.safeAreaInsets
    }
}
