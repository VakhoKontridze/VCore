//
//  KeyboardResponsiveUIViewControllerAnimations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Keyboard Animation - Custom
@available(tvOS, unavailable)
extension UIView {
    /// Animates changes to `UIView` using `SystemKeyboardInfo`.
    ///
    /// Much like `UIView` animations, there may be discrepancy between physical device and simulator.
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

// MARK: - Keyboard Animation - Container Offset by Obscured Subview Height
@available(tvOS, unavailable)
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
    /// Parameter `containerView` is `UIView` on which `bound` animations will be applied.
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
    public class func animateKeyboardResponsivenessByOffsettingContainerByObscuredSubviewHeight(
        keyboardWillShow: Bool,
        firstResponderView: UIView,
        containerView: UIView,
        systemKeyboardInfo: SystemKeyboardInfo,
        marginBottom: CGFloat = 20,
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

            let viewGlobalBoundsMaxY: CGFloat = firstResponderView.convert(firstResponderView.bounds, to: firstResponderView.window).maxY

            let containerViewY: CGFloat = containerView.bounds.origin.y

            guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else { return } // Will never fail

            let viewDistanceToBottom: CGFloat = windowHeight - viewGlobalBoundsMaxY - containerViewY
            let obscuredHeight: CGFloat = max(0, systemKeyboardHeight + marginBottom - viewDistanceToBottom)
            
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
