//
//  NavigationStackCoordinator.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Navigation Stack Coordinator
/// `ObservableObject` that stores `NavigationPath` for coordinating with `CoordinatingNavigationStack`.
///
/// Can be used to push or pop `View`s from `Presenter` or `ViewModel`.
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
@available(iOS 16.0, *)
@available(macOS 13.0, *)
@available(tvOS 16.0, *)
@available(watchOS 9.0, *)
public final class NavigationStackCoordinator: ObservableObject {
    // MARK: Properties
    /// `NavigationPath`.
    @Published public var path: NavigationPath
    
    // MARK: Initializers
    /// Initializes `NavigationStackCoordinator`.
    public init(path: NavigationPath) {
        self.path = path
    }
}
