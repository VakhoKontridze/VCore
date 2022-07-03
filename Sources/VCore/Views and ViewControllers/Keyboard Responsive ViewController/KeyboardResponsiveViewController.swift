//
//  KeyboardResponsiveViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if os(iOS)

import UIKit

// MARK: - Keyboard Responsive View Controller
/// Keyboard Responsive ViewController that handles keyboard notifications.
///
/// Subclass, and override `keyboardWillShow` and `keyboardWillHide` methods, to observe keyboard notifications.
/// These methods pass `SystemKeyboardInfo` as parameter, that contains information about keyboard height, animation duration, and options.
open class KeyboardResponsiveViewController: UIViewController {
    // MARK: Properties
    private var keyboardIsShown: Bool = false // `keyboardWillShowNotification` is called twice
    
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
        guard !keyboardIsShown else { return }
        keyboardIsShown = true
        
        guard viewIsVisible else { return }
        
        keyboardWillShow(.init(notification: notification))
    }
    
    /// Posted immediately prior to the dismissal of the keyboard.
    open func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {}
    
    private func keyboardWillHide(notification: Notification) {
        guard keyboardIsShown else { return }
        keyboardIsShown = false
        
        guard viewIsVisible else { return }
        
        keyboardWillHide(.init(notification: notification))
    }
    
    // MARK: Helpers
    private var viewIsVisible: Bool {
        viewIfLoaded?.window != nil
    }
}

#endif
