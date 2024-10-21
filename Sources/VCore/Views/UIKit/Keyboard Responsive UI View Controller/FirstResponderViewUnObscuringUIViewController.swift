//
//  FirstResponderViewUnObscuringUIViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - First Responder View Un-Obscuring UI View Controller
/// Subclass of  `KeyboardResponsiveUIViewController` that handles keyboard notifications by  un-obscuring first responder view, if needed.
@available(tvOS, unavailable)
open class FirstResponderViewUnObscuringUIViewController: KeyboardResponsiveUIViewController, Sendable {
    // MARK: Properties
    /// `UIView` on which offset animations will be applied. Set to `view`.
    ///
    /// In case of `UITableView`, `UITableView` itself can be used.
    ///
    /// In case of `UIScrollView`, content view can be used.
    open lazy var keyboardResponsivenessContainerView: UIView = view // Doesn't cause retain cycle

    /// Additional offset from first responder view to keyboard. Set to `20`.
    open var keyboardResponsivenessFirstResponderAdditionalOffset: CGFloat = 20

    // MARK: Keyboard Responsiveness
    open override func keyboardWillShow(_ systemKeyboardInfo: SystemKeyboardInfo) {
        super.keyboardWillShow(systemKeyboardInfo)
        
        guard let firstResponderSubview: UIView = view.childFirstResponderView else { return }
        
        UIView.animateKeyboardResponsivenessByUnObscuringFirstResponderView(
            keyboardWillShow: true,
            firstResponderView: firstResponderSubview,
            containerView: keyboardResponsivenessContainerView,
            systemKeyboardInfo: systemKeyboardInfo,
            additionalOffset: keyboardResponsivenessFirstResponderAdditionalOffset
        )
    }
    
    open override func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {
        super.keyboardWillHide(systemKeyboardInfo)
        
        guard let firstResponderSubview: UIView = view.childFirstResponderView else { return }
        
        UIView.animateKeyboardResponsivenessByUnObscuringFirstResponderView(
            keyboardWillShow: false,
            firstResponderView: firstResponderSubview,
            containerView: keyboardResponsivenessContainerView,
            systemKeyboardInfo: systemKeyboardInfo,
            additionalOffset: keyboardResponsivenessFirstResponderAdditionalOffset
        )
    }
}

#endif
