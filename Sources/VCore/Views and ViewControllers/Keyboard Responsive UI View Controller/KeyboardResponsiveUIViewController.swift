//
//  KeyboardResponsiveUIViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if os(iOS)

import UIKit

// MARK: - Keyboard Responsive UI View Controller
/// Keyboard Responsive ViewController that handles keyboard notifications.
///
/// Subclass, and override `keyboardWillShow` and `keyboardWillHide` methods, to observe keyboard notifications.
/// These methods pass `SystemKeyboardInfo` as parameter, that contains information about keyboard height, animation duration, and options.
open class KeyboardResponsiveUIViewController: UIViewController {
    // MARK: Properties
    /// Indicates, if `KeyboardResponsiveViewController` should call
    /// `keyboardWillShow(_:)` and `keyboardWillHide(_:)` methods,
    /// even if keyboard is already shown or hidden.
    /// Defaults to `true`.
    open var notifiesWhenKeyboardIsAlreadyShownOrHidden: Bool = true
    
    /// Indicates if keyboard is currently shown.
    open private(set) var keyboardIsShown: Bool = false
    
    /// Indicates, if `KeyboardResponsiveViewController` should call
    /// `keyboardWillShow(_:)` and `keyboardWillHide(_:)` methods,
    /// even if `KeyboardResponsiveViewController` is not visible.
    /// Defaults to `false`.
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
            using: keyboardWillShow
        )
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil,
            using: keyboardWillHide
        )
    }
    
    // MARK: Observers
    /// Posted immediately prior to the display of the keyboard.
    open func keyboardWillShow(_ systemKeyboardInfo: SystemKeyboardInfo) {}
    
    private func keyboardWillShow(notification: Notification) {
        if !notifiesWhenKeyboardIsAlreadyShownOrHidden {
            guard !keyboardIsShown else { return }
        }
        keyboardIsShown = true
        
        if !notifiesWhenViewControllerIsNotVisible {
            guard viewIsVisible else { return }
        }
        
        keyboardWillShow(.init(notification: notification))
    }
    
    /// Posted immediately prior to the dismissal of the keyboard.
    open func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {}
    
    private func keyboardWillHide(notification: Notification) {
        if !notifiesWhenKeyboardIsAlreadyShownOrHidden {
            guard keyboardIsShown else { return }
        }
        keyboardIsShown = false
        
        if !notifiesWhenViewControllerIsNotVisible {
            guard viewIsVisible else { return }
        }
        
        keyboardWillHide(.init(notification: notification))
    }
    
    // MARK: Helpers
    private var viewIsVisible: Bool {
        viewIfLoaded?.window != nil
    }
}

#endif
