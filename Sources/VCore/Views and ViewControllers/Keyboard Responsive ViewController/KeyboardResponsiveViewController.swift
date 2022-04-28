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
/// Subclass, and override `keyboardWillShow` and `keyboardWillHide` methods, to observe keyboard notificaations.
/// These methods pass `SystemKeyboardInfo` as parameter, that contains information about keyboard height, animation duration, and options.
open class KeyboardResponsiveViewController: UIViewController {
    // MARK: Properties
    private var keyboardIsShown: Bool = false   // `keyboardWillShowNotification` is called twice
    
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
            self,
            selector: #selector(keyboardWillShowObjc),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideObjc),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // MARK: Observers
    /// Posted immediately prior to the display of the keyboard.
    open func keyboardWillShow(_ systemKeyboardInfo: SystemKeyboardInfo) {}
    
    @objc private func keyboardWillShowObjc(notification: Notification) {
        guard !keyboardIsShown else { return }
        keyboardIsShown = true
        
        guard viewIsVisible else { return }
        
        keyboardWillShow(.init(notification: notification))
    }
    
    /// Posted immediately prior to the dismissal of the keyboard.
    open func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {}
    
    @objc private func keyboardWillHideObjc(notification: Notification) {
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
