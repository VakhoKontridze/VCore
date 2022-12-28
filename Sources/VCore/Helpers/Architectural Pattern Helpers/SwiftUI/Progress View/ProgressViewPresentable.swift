//
//  ProgressViewPresentable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Progress View Presentable
/// Protocol for presenting a `ProgressView`.
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
///                 .progressView(parameters: presenter.progressViewParameters)
///         }
///     }
///
///     final class Presenter: ObservableObject, ProgressViewPresentable {
///         @Published var progressViewParameters: ProgressViewParameters?
///
///         func didTapButton() {
///             Task(operation: {
///                 do {
///                     let (data, response) = try await URLSession.shared.data(for: request)
///                     progressViewParameters = nil
///
///                     ...
///
///                 } catch {
///                     progressViewParameters = nil
///
///                     ...
///                 }
///             })
///         }
///     }
///
@available(iOS 14.0, *)
@available(macOS 11.0, *)
@available(tvOS 14.0, *)
@available(watchOS 7.0, *)
@MainActor public protocol ProgressViewPresentable: ObservableObject {
    /// `ProgressViewParameters`.
    var progressViewParameters: ProgressViewParameters? { get set }
}
