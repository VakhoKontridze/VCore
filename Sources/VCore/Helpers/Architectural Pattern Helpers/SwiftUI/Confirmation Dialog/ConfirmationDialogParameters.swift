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
/// In `MVP`, `VIP`, and `VIPER` architectures, parameters are stored in`Presenter`.
/// in `MVVM` architecture, parameters are stored in `ViewModel.`
///
///     @State private var parameters: ConfirmationDialogParameters? = .init(
///         title: "Lorem Ipsum",
///         message: "Lorem ipsum dolor sit amet",
///         actions: {
///             ConfirmationDialogButton(title: "Confirm", action: { print("Confirmed") })
///             ConfirmationDialogButton(role: .cancel, title: "Cancel", action: { print("Cancelled") })
///         }
///     )
///
///     var body: some View {
///         content
///             .confirmationDialog(parameters: $parameters)
///     }
///
///
@available(iOS 15.0, *)
@available(macOS 12.0, *)
@available(tvOS 15.0, *)
@available(watchOS 8.0, *)
public struct ConfirmationDialogParameters {
    // MARK: Properties
    /// Title.
    public var title: String?
    
    /// Message.
    public var message: String?
    
    /// Buttons.
    public var buttons: () -> [any ConfirmationDialogButtonProtocol]
    
    // MARK: Initializers
    /// Initializes `ConfirmationDialogParameters`.
    public init(
        title: String?,
        message: String?,
        @ConfirmationDialogButtonBuilder actions buttons: @escaping () -> [any ConfirmationDialogButtonProtocol]
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
}
