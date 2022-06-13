//
//  UIRectCorner.AdditionalOptions.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.06.22.
//

#if canImport(UIKit)

import UIKit

// MARK: - UI Rect Corner Additional Options
extension UIRectCorner {
    /// Top corners.
    ///
    /// Includes `topLeft` and  `topRight`.
    public static var topCorners: UIRectCorner { [.topLeft, .topRight] }
    
    /// Right corners.
    ///
    /// Includes `topRight` and  `bottomRight`.
    public static var rightCorners: UIRectCorner { [.topRight, .bottomRight] }
    
    /// Bottom corners.
    ///
    /// Includes `bottomLeft` and  `bottomRight`.
    public static var bottomCorners: UIRectCorner { [.bottomLeft, .bottomRight] }
    
    /// Left corners.
    ///
    /// Includes `topLeft` and  `bottomLeft`.
    public static var leftCorners: UIRectCorner { [.topLeft, .bottomLeft] }
}

#endif
