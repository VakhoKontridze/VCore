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
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
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
