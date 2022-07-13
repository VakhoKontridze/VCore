//
//  UIView.FirstResponderSubview.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit)

import UIKit

// MARK: - UI View Subview First Responder
extension UIView {
    /// Returns first responder from `UIView`'s subviews.
    ///
    ///     let firstResponderSubview: UIResponder? = view.subviewFirstResponder
    ///
    public var firstResponderSubview: UIResponder? {
        if isFirstResponder { return self }
        
        for view in subviews {
            if let firstResponder: UIResponder = view.firstResponderSubview {
                return firstResponder
            }
        }
        
        return nil
    }
}

#endif
