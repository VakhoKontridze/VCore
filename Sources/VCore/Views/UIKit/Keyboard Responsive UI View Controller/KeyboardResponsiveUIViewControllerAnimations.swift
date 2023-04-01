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
    ///                     view.superview?.layoutIfNeeded()
    ///                     view.bounds.origin.y = -systemKeyboardInfo.frame.size.height
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
    ///                     view.superview?.layoutIfNeeded()
    ///                     view.bounds.origin.y = 0
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
                    firstResponderView.superview?.layoutIfNeeded()
                    containerView.superview?.layoutIfNeeded()
                    
                    containerView.bounds.origin.y = 0
                },
                completion: completion
            )
            
        case true:
            let windowHeight: CGFloat = firstResponderView.window?.frame.size.height ?? UIScreen.main.bounds.height
            
            let viewGlobalBounds: CGRect = firstResponderView.convert(firstResponderView.bounds, to: firstResponderView.window)
            let viewGlobalBoundsMaxY: CGFloat = viewGlobalBounds.maxY
            let viewDistanceToBottom: CGFloat = windowHeight - viewGlobalBoundsMaxY - containerView.bounds.origin.y
            
            let obscuredHeight: CGFloat = systemKeyboardInfo.frame.size.height + marginBottom - viewDistanceToBottom
            
            let offset: CGFloat = {
                if obscuredHeight > 0 {
                    return obscuredHeight
                } else {
                    return 0
                }
            }()

            UIView.animateKeyboardResponsiveness(
                systemKeyboardInfo: systemKeyboardInfo,
                animations: {
                    firstResponderView.superview?.layoutIfNeeded()
                    containerView.superview?.layoutIfNeeded()
                    
                    containerView.bounds.origin.y = offset
                },
                completion: completion
            )
        }
    }
}

#endif
