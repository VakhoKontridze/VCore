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
///     struct ContentView: View {
///         @StateObject private var presenter: Presenter = .init()
///
///         var body: some View {
///             Button(
///                 "Lorem ipsum",
///                 action: { presenter.didTapButton() }
///             )
///                 .confirmationDialog(parameters: $presenter.confirmationDialogParameters)
///         }
///     }
///
///     final class Presenter: ObservableObject, ConfirmationDialogPresentable {
///         @Published var confirmationDialogParameters: ConfirmationDialogParameters?
///
///         func didTapButton() {
///             confirmationDialogParameters = ConfirmationDialogParameters(
///                 title: "Lorem Ipsum",
///                 message: "Lorem ipsum dolor sit amet",
///                 actions: {
///                     ConfirmationDialogButton(title: "Confirm", action: { print("Confirmed") })
///                     ConfirmationDialogButton(role: .cancel, title: "Cancel", action: { print("Cancelled") })
///                 }
///             )
///         }
///     }
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
