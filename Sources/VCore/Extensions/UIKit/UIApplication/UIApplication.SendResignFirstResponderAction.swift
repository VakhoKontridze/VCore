//
//  UIApplication.SendResignFirstResponderAction.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16.08.23.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Application Send Resign First Responder Action
extension UIApplication {
    /// Sends `UIResponder.resignFirstResponder` selector to `UIApplication`.
    ///
    ///     UIApplication.shared.sendResignFirstResponderAction()
    ///
    public func sendResignFirstResponderAction() {
        let resign: Selector = #selector(UIResponder.resignFirstResponder)
        _ = sendAction(resign, to: nil, from: nil, for: nil)
    }
}

#endif
