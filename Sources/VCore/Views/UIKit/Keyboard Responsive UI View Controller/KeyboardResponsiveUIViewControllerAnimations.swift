//
//  KeyboardResponsiveUIViewControllerAnimations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - UIView + Animate Keyboard Responsiveness
@available(tvOS, unavailable)
extension UIView {
    /// Animates changes to `UIView` using `SystemKeyboardInfo`.
    ///
    /// Much like `UIView` animations, there may be discrepancy between physical device and simulator.
    ///
    ///     final class SomeViewController: KeyboardResponsiveUIViewController {
    ///         private let textField: UITextField = ...
    ///
    ///         override func viewDidLoad() {
    ///             super.viewDidLoad()
    ///
    ///             view.addSubview(textField)
    ///
    ///             NSLayoutConstraint.activate([
    ///                 ...
    ///             ])
    ///         }
    ///
    ///         override func keyboardWillShow(_ systemKeyboardInfo: SystemKeyboardInfo) {
    ///             super.keyboardWillShow(systemKeyboardInfo)
    ///
    ///             UIView.animateKeyboardResponsiveness(
    ///                 systemKeyboardInfo: systemKeyboardInfo,
    ///                 animations: { [weak self] in
    ///                     guard let self else { return }
    ///
    ///                     guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else { return }
    ///
    ///                     view.bounds.origin.y = systemKeyboardHeight
    ///                     view.superview?.layoutIfNeeded()
    ///                 }
    ///             )
    ///         }
    ///
    ///         override func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {
    ///             super.keyboardWillHide(systemKeyboardInfo)
    ///
    ///             UIView.animateKeyboardResponsiveness(
    ///                 systemKeyboardInfo: systemKeyboardInfo,
    ///                 animations: { [weak self] in
    ///                     guard let self else { return }
    ///
    ///                     view.bounds.origin.y = 0
    ///                     view.superview?.layoutIfNeeded()
    ///                 }
    ///             )
    ///         }
    ///     }
    ///
    public class func animateKeyboardResponsiveness(
        systemKeyboardInfo: SystemKeyboardInfo,
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        UIView.animate(
            withDuration: systemKeyboardInfo.nonZeroAnimationDuration,
            delay: 0,
            options: systemKeyboardInfo.animationOptions,
            animations: animations,
            completion: completion
        )
    }
}

// MARK: - UIView + Animate Keyboard Responsiveness - Un-Obscuring First Responder View
@available(tvOS, unavailable)
extension UIView {
    /// Animates changes to `UIView` using `SystemKeyboardInfo` to un-obscure first responder view, if needed.
    ///
    /// Alternately, check out `FirstResponderViewUnObscuringUIViewController`.
    ///
    /// In order to use this method on `UITableView`/`UITableViewCell`s, pass `tableView.childFirstResponderView`
    /// as parameter in `firstResponderView`.
    ///
    /// Much like `UIView` animations, there may be discrepancy between physical device and simulator.
    ///
    /// Parameter `containerView` is `UIView` on which `bound` animations will be applied.
    ///
    ///     final class SomeViewController: KeyboardResponsiveUIViewController {
    ///         private let textField: UITextField = ...
    ///
    ///         override func viewDidLoad() {
    ///             super.viewDidLoad()
    ///
    ///             view.addSubview(textField)
    ///
    ///             NSLayoutConstraint.activate([
    ///                 ...
    ///             ])
    ///         }
    ///
    ///         override func keyboardWillShow(_ systemKeyboardInfo: SystemKeyboardInfo) {
    ///             super.keyboardWillShow(systemKeyboardInfo)
    ///
    ///             UIView.animateKeyboardResponsivenessByUnObscuringFirstResponderView(
    ///                 keyboardWillShow: true,
    ///                 firstResponderView: textField,
    ///                 containerView: view,
    ///                 systemKeyboardInfo: systemKeyboardInfo
    ///             )
    ///         }
    ///
    ///         override func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {
    ///             super.keyboardWillHide(systemKeyboardInfo)
    ///
    ///             UIView.animateKeyboardResponsivenessByUnObscuringFirstResponderView(
    ///                 keyboardWillShow: false,
    ///                 firstResponderView: textField,
    ///                 containerView: view,
    ///                 systemKeyboardInfo: systemKeyboardInfo
    ///             )
    ///         }
    ///     }
    ///
    public class func animateKeyboardResponsivenessByUnObscuringFirstResponderView(
        keyboardWillShow: Bool,
        firstResponderView: UIView,
        containerView: UIView,
        systemKeyboardInfo: SystemKeyboardInfo,
        additionalOffset: CGFloat = 20,
        completion: ((Bool) -> Void)? = nil
    ) {
        switch keyboardWillShow {
        case false:
            UIView.animateKeyboardResponsiveness(
                systemKeyboardInfo: systemKeyboardInfo,
                animations: {
                    containerView.bounds.origin.y = 0
                    
                    firstResponderView.superview?.layoutIfNeeded()
                    containerView.superview?.layoutIfNeeded()
                },
                completion: completion
            )
            
        case true:
            guard let window: UIWindow = firstResponderView.window else { return } // Will never fail
            let windowHeight: CGFloat = window.frame.size.height

            guard let firstResponderViewSuperView: UIView = firstResponderView.superview else { return } // Will never fail
            let viewGlobalFrameMaxY: CGFloat = firstResponderViewSuperView.convert(firstResponderView.frame, to: nil).maxY

            let containerViewY: CGFloat = containerView.bounds.origin.y

            guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else { return } // Will never fail

            let viewDistanceToBottom: CGFloat = windowHeight - viewGlobalFrameMaxY - containerViewY
            
            let obscuredHeight: CGFloat = max(0, systemKeyboardHeight + additionalOffset - viewDistanceToBottom)

            UIView.animateKeyboardResponsiveness(
                systemKeyboardInfo: systemKeyboardInfo,
                animations: {
                    containerView.bounds.origin.y = obscuredHeight
                    
                    firstResponderView.superview?.layoutIfNeeded()
                    containerView.superview?.layoutIfNeeded()
                },
                completion: completion
            )
        }
    }
}

#endif
