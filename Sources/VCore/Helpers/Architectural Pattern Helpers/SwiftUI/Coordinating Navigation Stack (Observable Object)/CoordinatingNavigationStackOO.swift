//
//  CoordinatingNavigationStackOO.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI

// MARK: - Coordinating Navigation Stack (Observable Object)
/// `NavigationStack` that manages `NavigationPath` for representing content in the stack.
///
/// `View` embeds `NavigationStackCoordinatorOO` in the environment that can be used to by contents in the stack.
/// Can be used to push or pop `View`s programmatically.
///
///     var body: some View {
///         CoordinatingNavigationStackOO(root: {
///             HomeView()
///         })
///     }
///
///     struct HomeView: View {
///         @Environment(\.navigationStackCoordinatorOO) private var navigationStackCoordinator: NavigationStackCoordinatorOO!
///
///         var body: some View {
///             Button(
///                 "Navigate",
///                 action: { navigationStackCoordinator.path.append(DestinationParameters()) }
///             )
///             .navigationDestination(for: DestinationParameters.self, destination: DestinationView.init)
///         }
///     }
///
public struct CoordinatingNavigationStackOO<Root>: View, Sendable where Root: View { // TODO: iOS 17.0 - Remove, as it's obsoleted
    // MARK: Properties
    @StateObject private var navigationStackCoordinator: NavigationStackCoordinatorOO
    private let root: (NavigationStackCoordinatorOO) -> Root
    
    // MARK: Initializers - NavigationPath
    /// Initializes `CoordinatingNavigationStackOO`.
    public init(
        path navigationPath: @escaping @autoclosure () -> NavigationPath,
        @ViewBuilder root: @escaping (NavigationStackCoordinatorOO) -> Root
    ) {
        self._navigationStackCoordinator = StateObject(wrappedValue: NavigationStackCoordinatorOO(path: navigationPath()))
        self.root = root
    }
    
    /// Initializes `CoordinatingNavigationStackOO`.
    public init(
        path navigationPath: @escaping @autoclosure () -> NavigationPath,
        @ViewBuilder root: @escaping () -> Root
    ) {
        self._navigationStackCoordinator = StateObject(wrappedValue: NavigationStackCoordinatorOO(path: navigationPath()))
        self.root = { _ in root() }
    }
    
    // MARK: Initializers
    /// Initializes `CoordinatingNavigationStackOO`.
    public init(
        @ViewBuilder root: @escaping (NavigationStackCoordinatorOO) -> Root
    ) {
        self._navigationStackCoordinator = StateObject(wrappedValue: NavigationStackCoordinatorOO(path: NavigationPath()))
        self.root = root
    }
    
    /// Initializes `CoordinatingNavigationStackOO`.
    public init(
        @ViewBuilder root: @escaping () -> Root
    ) {
        self._navigationStackCoordinator = StateObject(wrappedValue: NavigationStackCoordinatorOO(path: NavigationPath()))
        self.root = { _ in root() }
    }
    
    // MARK: Body
    public var body: some View {
        NavigationStack(
            path: $navigationStackCoordinator.path,
            root: { root(navigationStackCoordinator) }
        )
        .environment(\.navigationStackCoordinatorOO, navigationStackCoordinator)
    }
}
