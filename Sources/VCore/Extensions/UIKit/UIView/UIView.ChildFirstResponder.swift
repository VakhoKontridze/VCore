//
//  UIView.FirstResponder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI View Child First Responder
extension UIView {
    /// Returns child first responder `UIResponder` from `UIView`'s subviews.
    ///
    ///     let childFirstResponder: UIResponder? = view.childFirstResponder
    ///
    public var childFirstResponder: UIResponder? {
        if isFirstResponder { return self }
        
        for view in subviews {
            if let firstResponder: UIResponder = view.childFirstResponder {
                return firstResponder
            }
        }
        
        return nil
    }
    
    /// Returns child first responder `UIView` from `UIView`'s subviews.
    ///
    ///     let childFirstResponderView: UIResponder? = view.childFirstResponderView
    ///
    public var childFirstResponderView: UIView? {
        childFirstResponder?.toView()
    }
}

// MARK: - Helpers
extension UIResponder {
    fileprivate func toView() -> UIView? {
        if let viewController = self as? UIViewController {
            viewController.view
        } else if let view = self as? UIView {
            view
        } else {
            nil
        }
    }
}

#endif
