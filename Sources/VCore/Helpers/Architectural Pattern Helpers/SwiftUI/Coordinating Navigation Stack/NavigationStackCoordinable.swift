//
//  NavigationStackCoordinable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Navigation Stack Coordinable
/// Protocol for managing `NavigationPath` within `NavigationStackCoordinator`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, this protocol is conformed to by a `Presenter`.
/// in `MVVM` architecture, this protocol is conformed to by a `ViewModel.`
///
///     struct HomeView: View {
///         @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator?
///         @StateObject private var presenter: HomePresenter
///         @State private var didAppearForTheFirstTime: Bool = false
///
///         var body: some View {
///             CoordinatingNavigationStack(root: {
///                 Button(
///                     "Lorem ipsum",
///                     action: { presenter.didTapButton() }
///                 )
///                     .modifier(HomeRouter())
///                     .onFirstAppear($didAppearForTheFirstTime, perform: {
///                         presenter.navigationStackCoordinator = navigationStackCoordinator
///                     })
///             })
///         }
///     }
///
///     struct HomeRouter: ViewModifier {
///         func body(content: Content) -> some View {
///             content
///                 .navigationDestination(
///                     for: DestinationParameters.self,
///                     destination: { DestinationView(parameters: $0) }
///                 )
///         }
///     }
///
///     final class HomePresenter: ObservableObject {
///         @Published var navigationStackCoordinator: NavigationStackCoordinator?
///
///         func didTapButton() {
///             navigationStackCoordinator?.path.append(DestinationParameters())
///         }
///     }
///
///     struct DestinationParameters: Hashable { ... }
///
///     struct DestinationView: View {
///         init(parameters: DestinationParameters) {
///             ...
///         }
///
///         var body: some View {
///             ...
///         }
///     }
///
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
@MainActor public protocol NavigationStackCoordinable: ObservableObject {
    /// Navigation stack coordinator.
    var navigationStackCoordinator: NavigationStackCoordinator? { get set }
}
