//
//  UIView+DismissKeyboardOnOutsideTap.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI View + Dismiss Keyboard on Outside Tap
extension UIView {
    /// Dismisses keyboard on outside tap, by resigning the first responder.
    ///
    ///     override func viewDidLoad() {
    ///         super.viewDidLoad()
    ///         view.dismissKeyboardOnOutsideTap()
    ///     }
    ///
    public func dismissKeyboardOnOutsideTap() {
        addGestureRecognizer({
            let gesture: UITapGestureRecognizer = .init(target: self, action: #selector(endEditingOnOutsideTap))
            gesture.cancelsTouchesInView = false
            return gesture
        }())
    }
    
    @objc 
    private func endEditingOnOutsideTap() {
        endEditing(true)
    }
}

#endif
