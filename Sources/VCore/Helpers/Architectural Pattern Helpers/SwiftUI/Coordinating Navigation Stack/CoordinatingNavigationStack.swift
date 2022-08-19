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
///
///     var body: some View {
///         CoordinatingNavigationStack(root: { coordinator in
///             ContentView()
///         })
///     }
///
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
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
