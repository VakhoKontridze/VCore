//
//  KeyboardResponsiveUIViewControllerAnimations.swift
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
    ///     final class SomeViewController: KeyboardResponsiveUIViewController {
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
    ///             super.keyboardWillShow(systemKeyboardInfo)
    ///
    ///             UIView.animateKeyboardResponsiveness(
    ///                 superview: view,
    ///                 systemKeyboardInfo: systemKeyboardInfo,
    ///                 animations: { [weak self] in self?.view.frame.origin.y = -systemKeyboardInfo.frame.height }
    ///             )
    ///         }
    ///
    ///         override func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {
    ///             super.keyboardWillHide(systemKeyboardInfo)
    ///
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
        UIView.animate(
            withDuration: systemKeyboardInfo.nonZeroAnimationDuration,
            delay: 0,
            options: systemKeyboardInfo.animationOptions,
            animations: {
                superview?.layoutIfNeeded()
                animations()
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
    ///     final class SomeViewController: KeyboardResponsiveUIViewController {
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
    ///             super.keyboardWillShow(systemKeyboardInfo)
    ///
    ///             UIView.animateKeyboardResponsivenessByOffsettingContainer(
    ///                 keyboardWillShow: true,
    ///                 superview: view,
    ///                 containerView: view,
    ///                 systemKeyboardInfo: systemKeyboardInfo
    ///             )
    ///         }
    ///
    ///         override func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {
    ///             super.keyboardWillHide(systemKeyboardInfo)
    ///
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
        UIView.animate(
            withDuration: systemKeyboardInfo.nonZeroAnimationDuration,
            delay: 0,
            options: systemKeyboardInfo.animationOptions,
            animations: {
                superview?.layoutIfNeeded()
                containerView.bounds.origin.y = {
                    if keyboardWillShow {
                        return systemKeyboardInfo.frame.height
                    } else {
                        return 0
                    }
                }()
            },
            completion: completion
        )
    }
}

// MARK: - Keyboard Animation - Container Offset by Obscured Subview Height
extension UIView {
    /// Animates changes to `UIView` using `SystemKeyboardInfo`, by offsetting container `y` origin by obscured subview height.
    ///
    /// Alternately, check out `KeyboardResponsiveUIViewControllerOffsettingContainerByObscuredSubviewHeight`.
    ///
    /// In order to use this method on `UITableView`/`UITableViewCell`s, pass `tableView.childFirstResponderView`
    /// as parameter in `firstResponderView`.
    ///
    /// Much like `UIView` animations, there may be discrepancy between physical device and simulator.
    ///
    /// Parameter `containerView` is `UIView` on which frame animations will be applied.
    ///
    ///     final class SomeViewController: KeyboardResponsiveUIViewController {
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
    ///             super.keyboardWillShow(systemKeyboardInfo)
    ///
    ///             UIView.animateKeyboardResponsivenessByOffsettingContainerByObscuredSubviewHeight(
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
    ///             UIView.animateKeyboardResponsivenessByOffsettingContainerByObscuredSubviewHeight(
    ///                 keyboardWillShow: false,
    ///                 firstResponderView: textField,
    ///                 containerView: view,
    ///                 systemKeyboardInfo: systemKeyboardInfo
    ///             )
    ///         }
    ///     }
    ///
    open class func animateKeyboardResponsivenessByOffsettingContainerByObscuredSubviewHeight(
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
                    return obscuredHeight
                } else {
                    return 0
                }
            }()
            
            UIView.animateKeyboardResponsiveness(
                superview: firstResponderView.superview,
                systemKeyboardInfo: systemKeyboardInfo,
                animations: { containerView.bounds.origin.y = offset },
                completion: completion
            )
        }
    }
}

#endif
