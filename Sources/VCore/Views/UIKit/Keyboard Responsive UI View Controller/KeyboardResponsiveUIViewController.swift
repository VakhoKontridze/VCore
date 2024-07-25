//
//  KeyboardResponsiveUIViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Keyboard Responsive UI View Controller
/// Keyboard Responsive `UIViewController` that handles keyboard notifications.
///
/// Subclass, and override `keyboardWillShow` and `keyboardWillHide` methods, to observe keyboard notifications.
/// These methods pass `SystemKeyboardInfo` as parameter, that contains information about keyboard height, animation duration, and options.
///
///     final class ViewController: KeyboardResponsiveUIViewController {
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
@available(tvOS, unavailable)
open class KeyboardResponsiveUIViewController: UIViewController {
    // MARK: Properties
    /// Indicates, if `keyboardWillShow(_:)` and `keyboardWillHide(_:)` are called, when keyboard is already shown or hidden. Set to `true`.
    open var notifiesWhenKeyboardIsAlreadyShownOrHidden: Bool = true
    
    /// Indicates if keyboard is currently shown.
    private(set) open var keyboardIsShown: Bool = false
    
    /// Indicates, if `keyboardWillShow(_:)` and `keyboardWillHide(_:)` are called, when `KeyboardResponsiveUIViewController` is not visible. Set to `false`.
    open var notifiesWhenViewControllerIsNotVisible: Bool = false
    
    // MARK: Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: Setup
    private func setUp() {
        addKeyboardFrameChangNotificationObserver()
    }
    
    private func addKeyboardFrameChangNotificationObserver() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: nil,
            using: { [weak self] in self?.keyboardWillShow(notification: $0) }
        )
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil,
            using: { [weak self] in self?.keyboardWillHide(notification: $0) }
        )
    }
    
    // MARK: Actions
    /// Posted immediately prior to the display of the keyboard.
    open func keyboardWillShow(_ systemKeyboardInfo: SystemKeyboardInfo) {}

    /// Posted immediately prior to the dismissal of the keyboard.
    open func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {}

    // MARK: Observers
    private func keyboardWillShow(notification: Notification) {
        if !notifiesWhenKeyboardIsAlreadyShownOrHidden {
            guard !keyboardIsShown else { return }
        }
        keyboardIsShown = true
        
        if !notifiesWhenViewControllerIsNotVisible {
            guard viewIsVisible else { return }
        }
        
        keyboardWillShow(SystemKeyboardInfo(notification: notification))
    }
    
    private func keyboardWillHide(notification: Notification) {
        if !notifiesWhenKeyboardIsAlreadyShownOrHidden {
            guard keyboardIsShown else { return }
        }
        keyboardIsShown = false
        
        if !notifiesWhenViewControllerIsNotVisible {
            guard viewIsVisible else { return }
        }
        
        keyboardWillHide(SystemKeyboardInfo(notification: notification))
    }
    
    // MARK: Helpers
    private var viewIsVisible: Bool {
        viewIfLoaded?.window != nil
    }
}

#endif
