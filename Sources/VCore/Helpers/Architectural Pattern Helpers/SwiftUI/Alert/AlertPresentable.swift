//
//  AlertPresentable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Alert Presentable
/// Protocol for presenting an `Alert`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, this protocol is conformed to by a `Presenter`.
/// in `MVVM` architecture, this protocol is conformed to by a `ViewModel`.
///
///     struct ContentView: View {
///         @StateObject private var presenter: Presenter = .init()
///
///         var body: some View {
///             Button(
///                 "Lorem ipsum",
///                 action: { presenter.didTapButton() }
///             )
///             .alert(parameters: $presenter.alertParameters)
///         }
///     }
///
///     @MainActor final class Presenter: ObservableObject, AlertPresentable {
///         @Published var alertParameters: AlertParameters?
///
///         func didTapButton() {
///             alertParameters = AlertParameters(
///                 title: "Lorem Ipsum",
///                 message: "Lorem ipsum dolor sit amet",
///                 actions: {
///                     AlertButton(action: { print("Confirmed") }, title: "Confirm")
///                     AlertButton(role: .cancel, action: { print("Cancelled") }, title: "Cancel")
///                 }
///             )
///         }
///     }
///
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@MainActor public protocol AlertPresentable: ObservableObject {
    /// `AlertParameters`.
    var alertParameters: AlertParameters? { get set }
}
