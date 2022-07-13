//
//  KeyboardResponsiveViewControllerAnimations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12.07.22.
//

#if os(iOS)

import UIKit

// MARK: - Keyboard Animation - Custom
extension UIView {
    /// Animates changes to `UIView` using `SystemKeyboardInfo`.
    ///
    /// Much like `UIView` animations, there may be discrepancy between physical device and simulator.
    ///
    /// Parameter `superview` is used for calling `layoutIfNeeded()`.
    /// In `UIViewController`, `view` can be passed.
    ///
    ///     final class SomeViewController: KeyboardResponsiveViewController {
    ///         private let textField: UITextField = { ... }()
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
    ///             UIView.animateKeyboardResponsiveness(
    ///                 superview: view,
    ///                 systemKeyboardInfo: systemKeyboardInfo,
    ///                 animations: { [weak self] in self?.view.frame.origin.y = -systemKeyboardInfo.frame.height }
    ///             )
    ///         }
    ///
    ///         override func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {
    ///             UIView.animateKeyboardResponsiveness(
    ///                 superview: view,
    ///                 systemKeyboardInfo: systemKeyboardInfo,
    ///                 animations: { [weak self] in self?.view.frame.origin.y = 0 }
    ///             )
    ///         }
    ///     }
    ///
    open class func animateKeyboardResponsiveness(
        superview: UIView?,
        systemKeyboardInfo: SystemKeyboardInfo,
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        let animationDuration: TimeInterval = max(systemKeyboardInfo.animationDuration, SystemKeyboardInfo.defaultAnimationDuration)
        
        superview?.layoutIfNeeded()
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: systemKeyboardInfo.animationOptions,
            animations: {
                animations()
                superview?.layoutIfNeeded()
            },
            completion: completion
        )
    }
}

// MARK: - Keyboard Animation - Container Offset
extension UIView {
    /// Animates changes to `UIView` using `SystemKeyboardInfo`, by offsetting container `y` origin by keyboard height.
    ///
    /// Much like `UIView` animations, there may be discrepancy between physical device and simulator.
    ///
    /// Parameter `superview` is used for calling `layoutIfNeeded()`.
    /// In `UIViewController`, `view` can be passed.
    ///
    /// Parameter `containerView` is `UIView` on which frame animations will be applied.
    ///
    ///     final class SomeViewController: KeyboardResponsiveViewController {
    ///         private let textField: UITextField = { ... }()
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
    ///             UIView.animateKeyboardResponsivenessByOffsettingContainer(
    ///                 keyboardWillShow: true,
    ///                 superview: view,
    ///                 containerView: view,
    ///                 systemKeyboardInfo: systemKeyboardInfo
    ///             )
    ///         }
    ///
    ///         override func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {
    ///             UIView.animateKeyboardResponsivenessByOffsettingContainer(
    ///                 keyboardWillShow: false,
    ///                 superview: view,
    ///                 containerView: view,
    ///                 systemKeyboardInfo: systemKeyboardInfo
    ///             )
    ///         }
    ///     }
    ///
    open class func animateKeyboardResponsivenessByOffsettingContainer(
        keyboardWillShow: Bool,
        superview: UIView?,
        containerView: UIView,
        systemKeyboardInfo: SystemKeyboardInfo,
        completion: ((Bool) -> Void)? = nil
    ) {
        let animationDuration: TimeInterval = max(systemKeyboardInfo.animationDuration, SystemKeyboardInfo.defaultAnimationDuration)
        
        superview?.layoutIfNeeded()
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: systemKeyboardInfo.animationOptions,
            animations: {
                containerView.frame.origin.y = {
                    if keyboardWillShow {
                        return -systemKeyboardInfo.frame.height
                    } else {
                        return 0
                    }
                }()
                superview?.layoutIfNeeded()
            },
            completion: completion
        )
    }
}

// MARK: - Keyboard Animation - Minimal Container Offset
extension UIView {
    /// Animates changes to `UIView` using `SystemKeyboardInfo`, by offsetting container `y` origin by minimal distance,
    /// so that `firstResponderView` is not obscured by the keyboard.
    ///
    /// Much like `UIView` animations, there may be discrepancy between physical device and simulator.
    ///
    /// Parameter `containerView` is `UIView` on which frame animations will be applied.
    ///
    ///     final class SomeViewController: KeyboardResponsiveViewController {
    ///         private let textField: UITextField = { ... }()
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
    ///             UIView.animateKeyboardResponsivenessByMinimallyOffsettingContainer(
    ///                 keyboardWillShow: true,
    ///                 firstResponderView: textField,
    ///                 containerView: view,
    ///                 systemKeyboardInfo: systemKeyboardInfo
    ///             )
    ///         }
    ///
    ///         override func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {
    ///             UIView.animateKeyboardResponsivenessByMinimallyOffsettingContainer(
    ///                 keyboardWillShow: false,
    ///                 firstResponderView: textField,
    ///                 containerView: view,
    ///                 systemKeyboardInfo: systemKeyboardInfo
    ///             )
    ///         }
    ///     }
    ///
    open class func animateKeyboardResponsivenessByMinimallyOffsettingContainer(
        keyboardWillShow: Bool,
        firstResponderView: UIView,
        containerView: UIView,
        systemKeyboardInfo: SystemKeyboardInfo,
        marginBottom: CGFloat = 20,
        completion: ((Bool) -> Void)? = nil
    ) {
        switch keyboardWillShow {
        case false:
            UIView.animateKeyboardResponsivenessByOffsettingContainer(
                keyboardWillShow: false,
                superview: firstResponderView.superview,
                containerView: containerView,
                systemKeyboardInfo: systemKeyboardInfo,
                completion: completion
            )
            
        case true:
            let windowHeight: CGFloat = firstResponderView.window?.frame.height ?? UIScreen.main.bounds.height
            
            let viewGlobalBounds: CGRect = firstResponderView.convert(firstResponderView.bounds, to: firstResponderView.window)
            let viewGlobalBoundsMaxY: CGFloat = viewGlobalBounds.maxY
            let viewDistanceToBottom: CGFloat = windowHeight - viewGlobalBoundsMaxY
            
            let obscuredHeight: CGFloat = systemKeyboardInfo.frame.height + marginBottom - viewDistanceToBottom
            
            let offset: CGFloat = {
                if obscuredHeight > 0 {
                    return -obscuredHeight
                } else {
                    return 0
                }
            }()
            
            UIView.animateKeyboardResponsiveness(
                superview: firstResponderView.superview,
                systemKeyboardInfo: systemKeyboardInfo,
                animations: { containerView.frame.origin.y = offset },
                completion: completion
            )
        }
    }
}

#endif
