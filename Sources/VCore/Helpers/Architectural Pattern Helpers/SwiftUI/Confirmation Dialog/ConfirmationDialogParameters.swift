//
//  ConfirmationDialogParameters.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.08.22.
//

import SwiftUI

// MARK: - ConfirmationDialog Parameters
/// Parameters for presenting a `ConfirmationDialog`.
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
///
public struct ConfirmationDialogParameters {
    // MARK: Properties
    /// Title.
    public var title: String?
    
    /// Message.
    public var message: String?
    
    /// Buttons.
    public var buttons: () -> [any ConfirmationDialogButtonProtocol]

    /// Attributes.
    public var attributes: [String: Any] = [:]

    // MARK: Initializers
    /// Initializes `ConfirmationDialogParameters`.
    public init(
        title: String?,
        message: String?,
        @ConfirmationDialogButtonBuilder actions buttons: @escaping () -> [any ConfirmationDialogButtonProtocol],
        attributes: [String: Any] = [:]
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
        self.attributes = attributes
    }
}
