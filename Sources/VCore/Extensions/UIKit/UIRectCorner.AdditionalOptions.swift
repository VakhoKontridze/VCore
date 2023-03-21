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
    /// Top corners of the rectangle.
    ///
    /// Includes `topLeft` and  `topRight`.
    public static var topCorners: Self { [.topLeft, .topRight] }
    
    /// Right corners of the rectangle.
    ///
    /// Includes `topRight` and  `bottomRight`.
    public static var rightCorners: Self { [.topRight, .bottomRight] }
    
    /// Bottom corners of the rectangle.
    ///
    /// Includes `bottomLeft` and  `bottomRight`.
    public static var bottomCorners: Self { [.bottomLeft, .bottomRight] }
    
    /// Left corners of the rectangle.
    ///
    /// Includes `topLeft` and  `bottomLeft`.
    public static var leftCorners: Self { [.topLeft, .bottomLeft] }
}

#endif
