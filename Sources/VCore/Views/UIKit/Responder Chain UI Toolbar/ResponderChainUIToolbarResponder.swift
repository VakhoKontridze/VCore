//
//  ResponderChainUIToolbarResponder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.11.23.
//

#if canImport(UIKit) && !(os(tvOS) || os(watchOS) || os(visionOS))

import UIKit

// MARK: - Responder Chain UI Toolbar Responder
/// Object that supports input and can represent a responder in `ResponderChainUIToolbarManager`.
///
/// `UITextField` and `UITextView` automatically conform to this `protocol`.
public protocol ResponderChainUIToolbarResponder: AnyObject {
    /// Custom input accessory `UIView` to display when the responder becomes the first responder.
    var inputAccessoryView: UIView? { get set }

    /// Asks `UIKit` to make this object the first responder in its `UIWindow`.
    func becomeFirstResponder() -> Bool

    /// Notifies this object that it has been asked to relinquish its status as first responder in its `UIWindow`.
    func resignFirstResponder() -> Bool
}

extension UITextField: ResponderChainUIToolbarResponder {}

extension UITextView: ResponderChainUIToolbarResponder {}

#endif
