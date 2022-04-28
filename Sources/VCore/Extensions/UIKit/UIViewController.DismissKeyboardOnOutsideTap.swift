//
//  UIViewController.DismissKeyboardOnOutsideTap.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

#if canImport(UIKit) && !os(watchOS)

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
        view.addGestureRecognizer({
            let gesture: UITapGestureRecognizer = .init(target: self, action: #selector(endEditingFromOutsideTap))
            gesture.cancelsTouchesInView = false
            return gesture
        }())
    }

    @objc private func endEditingFromOutsideTap() {
        view.endEditing(true)
    }
}

#endif
