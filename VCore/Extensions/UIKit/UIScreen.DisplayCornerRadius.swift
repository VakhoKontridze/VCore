//
//  UIScreen.DisplayCornerRadius.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/9/21.
//

import UIKit

// MARK: - Screen Display Corner Radius
extension UIScreen {
    /// The corner radius of the display.
    ///
    /// Accessed private API and may be deprecated.
    public var displayCornerRadius: CGFloat? {
        value(forKey: "_displayCornerRadius") as? CGFloat
    }
}