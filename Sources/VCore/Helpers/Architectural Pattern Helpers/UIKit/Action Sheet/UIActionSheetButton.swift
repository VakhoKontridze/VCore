//
//  UIActionSheetButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.08.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Action Sheet Button
/// `UIActionSheetController` button.
///
///     presentActionSheet(parameters: .init(
///         title: "Lorem Ipsum",
///         message: "Lorem ipsum dolor sit amet",
///         actions: {
///             UIActionSheetButton(title: "Confirm", action: { print("Confirmed") })
///             UIActionSheetButton(style: .cancel, title: "Cancel", action: { print("Cancelled") })
///         }
///     ))
///
public struct UIActionSheetButton: UIActionSheetButtonProtocol {
    // MARK: Properties
    /// Indicates if button is enabled.
    public var isEnabled: Bool
    
    /// Style.
    public var style: UIAlertAction.Style
    
    /// Title.
    public var title: String
    
    /// Action.
    public var action: (() -> Void)?
    
    // MARK: Initializers
    /// Initializes `UIActionSheetButton`.
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
    public func makeBody() -> UIAlertAction {
        let alertAction: UIAlertAction = .init(
            title: title,
            style: style,
            handler: { _ in action?() }
        )
        alertAction.isEnabled = isEnabled

        return alertAction
    }
}

#endif
