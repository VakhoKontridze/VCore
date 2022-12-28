//
//  UIAlertButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Alert Button Protocol
/// `UIAlertController` button protocol.
public protocol UIAlertButtonProtocol: UIAlertButtonConvertible {
    /// Converts `UIAlertButtonProtocol` to `UIAlertAction`.
    var toUIAlertAction: UIAlertAction { get }
}

extension UIAlertButtonProtocol {
    public func toButtons() -> [any UIAlertButtonProtocol] { [self] }
}

// MARK: - UI Alert Button
/// `UIAlertController` button.
///
///     presentAlert(parameters: .init(
///         title: "Lorem Ipsum",
///         message: "Lorem ipsum dolor sit amet",
///         actions: {
///             UIAlertButton(title: "Confirm", action: { print("Confirmed") })
///             UIAlertButton(style: .cancel, title: "Cancel", action: { print("Cancelled") })
///         }
///     ))
///     
public struct UIAlertButton: UIAlertButtonProtocol {
    // MARK: Properties
    /// Indicates if button is enabled.
    public var isEnabled: Bool
    
    /// Style.
    public let style: UIAlertAction.Style
    
    /// Title.
    public var title: String
    
    /// Action.
    public var action: (() -> Void)?
    
    // MARK: Initializers
    /// Initializes `UIAlertButton`.
    public init(
        isEnabled: Bool = true,
        style: UIAlertAction.Style = .default,
        title: String,
        action: (() -> Void)?
    ) {
        self.isEnabled = isEnabled
        self.style = style
        self.title = title
        self.action = action
    }
    
    // MARK: Body
    public var toUIAlertAction: UIAlertAction {
        .init(
            isEnabled: isEnabled,
            title: title,
            style: style,
            handler: { _ in action?() }
        )
    }
}

// MARK: - Helpers
extension UIAlertAction {
    fileprivate convenience init(
        isEnabled: Bool,
        title: String?,
        style: UIAlertAction.Style,
        handler: ((UIAlertAction) -> Void)? = nil
    ) {
        self.init(
            title: title,
            style: style,
            handler: handler
        )
        
        self.isEnabled = isEnabled
    }
}

#endif
