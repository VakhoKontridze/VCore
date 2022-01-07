//
//  UIViewController.DismissKeyboardOnOutsideTap.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import UIKit

// MARK: - Dismiss Keyboard On Outside Tap
extension UIViewController {
    /// Dismisses keyboard on outside tap, by resigning first responder of the view.
    ///
    /// Usage Example:
    ///
    ///     override func viewDidLoad() {
    ///         super.viewDidLoad()
    ///         dismissKeyboardOnOutisdeTap()
    ///     }
    ///
    public func dismissKeyboardOnOutisdeTap() {
        let tap: UITapGestureRecognizer = .init(target: self, action: #selector(endEditingFromOutsideTap))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func endEditingFromOutsideTap() {
        view.endEditing(true)
    }
}
