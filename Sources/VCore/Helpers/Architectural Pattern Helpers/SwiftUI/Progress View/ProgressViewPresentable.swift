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
///             progressViewParameters = .init(isInteractionDisabled: true)
///             DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in self?.progressViewParameters = nil })
///         }
///     }
///
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
@MainActor public protocol ProgressViewPresentable: ObservableObject {
    /// `ProgressViewParameters`.
    var progressViewParameters: ProgressViewParameters? { get set }
}
