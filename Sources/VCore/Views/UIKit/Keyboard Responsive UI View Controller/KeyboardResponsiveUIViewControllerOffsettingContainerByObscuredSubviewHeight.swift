//
//  KeyboardResponsiveUIViewControllerOffsettingContainerByObscuredSubviewHeight.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Keyboard Responsive UI View Controller Offsetting Container by Obscured Subview Height
/// Subclass of  `KeyboardResponsiveUIViewController` that handles keyboard notifications by offsetting container by the obscured subview height.
@available(tvOS, unavailable)
open class KeyboardResponsiveUIViewControllerOffsettingContainerByObscuredSubviewHeight: KeyboardResponsiveUIViewController {
    // MARK: Properties
    /// `UIView` on which offset animations will be applied. Set to `view`.
    ///
    /// In case of `UITableView`, `UITableView` itself can be used.
    ///
    /// In case of `UIScrollView`, content view can be used.
    open var keyboardResponsivenessContainerView: UIView { view }

    /// Bottom margin from first responder view to keyboard. Set to `20`.
    open var keyboardResponsivenessFirstResponderViewMarginBottomToKeyboard: CGFloat { 20 }
    
    // MARK: Keyboard Responsiveness
    open override func keyboardWillShow(_ systemKeyboardInfo: SystemKeyboardInfo) {
        super.keyboardWillShow(systemKeyboardInfo)
        
        guard let firstResponderSubview: UIView = view.childFirstResponderView else { return }
        
        UIView.animateKeyboardResponsivenessByOffsettingContainerByObscuredSubviewHeight(
            keyboardWillShow: true,
            firstResponderView: firstResponderSubview,
            containerView: keyboardResponsivenessContainerView,
            systemKeyboardInfo: systemKeyboardInfo,
            marginBottom: keyboardResponsivenessFirstResponderViewMarginBottomToKeyboard
        )
    }
    
    open override func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {
        super.keyboardWillHide(systemKeyboardInfo)
        
        guard let firstResponderSubview: UIView = view.childFirstResponderView else { return }
        
        UIView.animateKeyboardResponsivenessByOffsettingContainerByObscuredSubviewHeight(
            keyboardWillShow: false,
            firstResponderView: firstResponderSubview,
            containerView: keyboardResponsivenessContainerView,
            systemKeyboardInfo: systemKeyboardInfo,
            marginBottom: keyboardResponsivenessFirstResponderViewMarginBottomToKeyboard
        )
    }
}

#endif
