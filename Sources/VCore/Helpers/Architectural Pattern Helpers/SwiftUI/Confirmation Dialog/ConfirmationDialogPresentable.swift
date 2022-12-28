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
@available(iOS 15.0, *)
@available(macOS 12.0, *)
@available(tvOS 15.0, *)
@available(watchOS 8.0, *)
@MainActor public protocol ConfirmationDialogPresentable: ObservableObject {
    /// `ConfirmationDialogParameters`.
    var confirmationDialogParameters: ConfirmationDialogParameters? { get set }
}
