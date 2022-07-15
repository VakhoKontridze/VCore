//
//  KeyboardResponsiveUIViewControllerOffsettingContainerByObscuredSubviewHeight.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.07.22.
//

#if os(iOS)

import UIKit

// MARK: - Keyboard Responsive UI View Controller Offsetting Container by Obscured Subview Height
/// Subclass of  `KeyboardResponsiveUIViewController` that handles keyboard notifications by offsetting container by the obscured subview height.
open class KeyboardResponsiveUIViewControllerOffsettingContainerByObscuredSubviewHeight: KeyboardResponsiveUIViewController {
    open override func keyboardWillShow(_ systemKeyboardInfo: SystemKeyboardInfo) {
        super.keyboardWillShow(systemKeyboardInfo)
        
        guard let firstResponderSubview = view.childFirstResponderView else { return }
        
        UIView.animateKeyboardResponsivenessByOffsettingContainerByObscuredSubviewHeight(
            keyboardWillShow: true,
            firstResponderView: firstResponderSubview,
            containerView: view,
            systemKeyboardInfo: systemKeyboardInfo
        )
    }
    
    open override func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {
        super.keyboardWillHide(systemKeyboardInfo)
        
        guard let firstResponderSubview = view.childFirstResponderView else { return }
        
        UIView.animateKeyboardResponsivenessByOffsettingContainerByObscuredSubviewHeight(
            keyboardWillShow: false,
            firstResponderView: firstResponderSubview,
            containerView: view,
            systemKeyboardInfo: systemKeyboardInfo
        )
    }
}

#endif
