//
//  ConfirmationDialogPresentable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.08.22.
//

import SwiftUI

// MARK: - Confirmation Dialog Presentable
/// Protocol for presenting an `ConfirmationDialog`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, this protocol is conformed to by a `Presenter`.
/// in `MVVM` architecture, this protocol is conformed to by a `ViewModel.`
///
///     struct ContentView: View {
///         @StateObject private var presenter: Presenter = .init()
///
///         var body: some View {
///             Button(
///                 "Lorem ipsum",
///                 action: { presenter.didTapButton() }
///             )
///             .confirmationDialog(parameters: $presenter.confirmationDialogParameters)
///         }
///     }
///
///     @MainActor final class Presenter: ObservableObject, ConfirmationDialogPresentable {
///         @Published var confirmationDialogParameters: ConfirmationDialogParameters?
///
///         func didTapButton() {
///             confirmationDialogParameters = ConfirmationDialogParameters(
///                 title: "Lorem Ipsum",
///                 message: "Lorem ipsum dolor sit amet",
///                 actions: {
///                     ConfirmationDialogButton(action: { print("Confirmed") }, title: "Confirm")
///                     ConfirmationDialogButton(role: .cancel, action: { print("Cancelled") }, title: "Cancel")
///                 }
///             )
///         }
///     }
///
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@MainActor public protocol ConfirmationDialogPresentable: ObservableObject {
    /// `ConfirmationDialogParameters`.
    var confirmationDialogParameters: ConfirmationDialogParameters? { get set }
}
