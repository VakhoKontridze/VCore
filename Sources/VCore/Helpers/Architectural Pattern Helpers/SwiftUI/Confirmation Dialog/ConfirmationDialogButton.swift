//
//  ConfirmationDialogButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.08.22.
//

import SwiftUI

// MARK: - Confirmation Dialog Button
/// `ConfirmationDialog` button.
///
///     @State private var parameters: ConfirmationDialogParameters?
///
///     var body: some View {
///         Button(
///             "Present",
///             action: {
///                 parameters = ConfirmationDialogParameters(
///                     title: "Lorem Ipsum",
///                     message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
///                     actions: {
///                         ConfirmationDialogButton(action: { print("Confirmed") }, title: "Confirm")
///                         ConfirmationDialogButton(role: .cancel, action: { print("Cancelled") }, title: "Cancel")
///                     }
///                 )
///             }
///         )
///         .confirmationDialog(parameters: $parameters)
///     }
///
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct ConfirmationDialogButton: ConfirmationDialogButtonProtocol {
    // MARK: Properties
    private var isEnabled: Bool = true
    private let role: ButtonRole?
    private let title: String
    private let action: (() -> Void)?
    
    // MARK: Initializers
    /// Initializes `ConfirmationDialogButton`.
    public init(
        role: ButtonRole? = nil,
        action: (() -> Void)?,
        title: String
    ) {
        self.role = role
        self.title = title
        self.action = action
    }
    
    // MARK: Button Protocol
    public func makeBody(
        animateOut: @escaping (/*completion*/ (() -> Void)?) -> Void
    ) -> AnyView {
        .init(
            Button(
                title,
                role: role,
                action: { animateOut(/*completion: */action) }
            )
            .disabled(!isEnabled)
        )
    }
    
    // MARK: Modifiers
    /// Adds a condition that controls whether users can interact with the button.
    public func disabled(_ disabled: Bool) -> Self {
        var button = self
        button.isEnabled = !disabled
        return button
    }
}
