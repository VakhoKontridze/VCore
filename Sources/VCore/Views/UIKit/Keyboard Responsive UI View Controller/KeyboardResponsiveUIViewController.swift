//
//  KeyboardResponsiveUIViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit
import Combine

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
///                 systemKeyboardInfo: systemKeyboardInfo
///             ) { [weak self] in
///                 guard let self else { return }
///
///                 guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else { return }
///
///                 view.bounds.origin.y = systemKeyboardHeight
///                 view.superview?.layoutIfNeeded()
///             }
///
///             UIView.animateKeyboardResponsiveness(
///                 systemKeyboardInfo: systemKeyboardInfo
///             ) { [weak self] in
///                 guard let self else { return }
///
///                 view.bounds.origin.y = 0
///                 view.superview?.layoutIfNeeded()
///             }
///     }
///
@available(tvOS, unavailable)
open class KeyboardResponsiveUIViewController: UIViewController {
    // MARK: Properties - Flags
    /// Indicates, if `keyboardWillShow(_:)` and `keyboardWillHide(_:)` are called, when keyboard is already shown or hidden.
    open var notifiesWhenKeyboardIsAlreadyShownOrHidden: Bool = true
    
    /// Indicates if keyboard is currently shown.
    private(set) open var keyboardIsShown: Bool = false
    
    /// Indicates, if `keyboardWillShow(_:)` and `keyboardWillHide(_:)` are called, when `KeyboardResponsiveUIViewController` is not visible.
    open var notifiesWhenViewControllerIsNotVisible: Bool = false
    
    // MARK: Properties - Subscriptions
    private var cancellables: Set<AnyCancellable> = []
    
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
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] in self?.keyboardWillShow(notification: $0) }
            .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] in self?.keyboardWillHide(notification: $0) }
            .store(in: &cancellables)
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
        isViewLoaded &&
        view.window != nil &&
        !isBeingDismissed
    }
}

#endif
