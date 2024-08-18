//
//  UIViewController+DismissKeyboardOnOutsideTap.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI View Controller + Dismiss Keyboard on Outside Tap
extension UIViewController {
    /// Dismisses keyboard on outside tap, by resigning first responder of the view.
    ///
    ///     override func viewDidLoad() {
    ///         super.viewDidLoad()
    ///         dismissKeyboardOnOutsideTap()
    ///     }
    ///
    public func dismissKeyboardOnOutsideTap() {
        view.addGestureRecognizer({
            let gesture: UITapGestureRecognizer = .init(target: self, action: #selector(endEditingOnOutsideTap))
            gesture.cancelsTouchesInView = false
            return gesture
        }())
    }
    
    @objc 
    private func endEditingOnOutsideTap() {
        view.endEditing(true)
    }
}

#endif
