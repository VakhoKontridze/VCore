//
//  CoordinatingNavigationStack.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI

// MARK: - Coordinating Navigation Stack
/// `NavigationStack` that manages `NavigationPath` for representing content in the stack.
///
/// `View` embeds `NavigationStackCoordinator` to the environment for it to be used by contents in the stack.
/// Can be used to pass `NavigationStackCoordinator` to `Presenter` or `ViewModel` for pushing or popping.
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
public struct CoordinatingNavigationStack<Root>: View where Root: View {
    // MARK: Properties
    @StateObject private var navigationStackCoordinator: NavigationStackCoordinator
    private let root: (NavigationStackCoordinator) -> Root

    // MARK: Initializers
    /// Initializes `CoordinatingNavigationStack`.
    public init(
        path navigationPath: @escaping @autoclosure () -> NavigationPath,
        @ViewBuilder root: @escaping (NavigationStackCoordinator) -> Root
    ) {
        self._navigationStackCoordinator = .init(wrappedValue: .init(path: navigationPath()))
        self.root = root
    }
    
    /// Initializes `CoordinatingNavigationStack`.
    public init(
        @ViewBuilder root: @escaping (NavigationStackCoordinator) -> Root
    ) {
        self._navigationStackCoordinator = .init(wrappedValue: .init(path: .init()))
        self.root = root
    }
    
    /// Initializes `CoordinatingNavigationStack`.
    public init(
        path navigationPath: @escaping @autoclosure () -> NavigationPath,
        @ViewBuilder root: @escaping () -> Root
    ) {
        self._navigationStackCoordinator = .init(wrappedValue: .init(path: navigationPath()))
        self.root = { _ in root() }
    }
    
    /// Initializes `CoordinatingNavigationStack`.
    public init(
        @ViewBuilder root: @escaping () -> Root
    ) {
        self._navigationStackCoordinator = .init(wrappedValue: .init(path: .init()))
        self.root = { _ in root() }
    }

    // MARK: Body
    public var body: some View {
        NavigationStack(
            path: $navigationStackCoordinator.path,
            root: { root(navigationStackCoordinator) }
        )
            .environment(\.navigationStackCoordinator, navigationStackCoordinator)
    }
}
