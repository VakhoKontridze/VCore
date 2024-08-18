//
//  CoordinatingNavigationStack.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.09.23.
//

import SwiftUI

// MARK: - Coordinating Navigation Stack
/// `NavigationStack` that manages `NavigationPath` for representing content in the stack.
///
/// `View` embeds `NavigationStackCoordinator` in the environment that can be used to by contents in the stack.
/// Can be used to push or pop `View`s programmatically.
///
///     var body: some View {
///         CoordinatingNavigationStack(root: {
///             HomeView()
///         })
///     }
///
///     struct HomeView: View {
///         @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator!
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
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct CoordinatingNavigationStack<Root>: View where Root: View {
    // MARK: Properties
    @State private var navigationStackCoordinator: NavigationStackCoordinator
    private let root: (NavigationStackCoordinator) -> Root

    // MARK: Initializers - NavigationPath
    /// Initializes `CoordinatingNavigationStack`.
    public init(
        path navigationPath: @escaping @autoclosure () -> NavigationPath,
        @ViewBuilder root: @escaping (NavigationStackCoordinator) -> Root
    ) {
        self._navigationStackCoordinator = State(wrappedValue: NavigationStackCoordinator(path: navigationPath()))
        self.root = root
    }

    /// Initializes `CoordinatingNavigationStack`.
    public init(
        path navigationPath: @escaping @autoclosure () -> NavigationPath,
        @ViewBuilder root: @escaping () -> Root
    ) {
        self._navigationStackCoordinator = State(wrappedValue: NavigationStackCoordinator(path: navigationPath()))
        self.root = { _ in root() }
    }

    // MARK: Initializers
    /// Initializes `CoordinatingNavigationStack`.
    public init(
        @ViewBuilder root: @escaping (NavigationStackCoordinator) -> Root
    ) {
        self._navigationStackCoordinator = State(wrappedValue: NavigationStackCoordinator(path: NavigationPath()))
        self.root = root
    }

    /// Initializes `CoordinatingNavigationStack`.
    public init(
        @ViewBuilder root: @escaping () -> Root
    ) {
        self._navigationStackCoordinator = State(wrappedValue: NavigationStackCoordinator(path: NavigationPath()))
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

// MARK: - Preview
#if DEBUG

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview(body: {
    struct ContentView: View {
        var body: some View {
            CoordinatingNavigationStack(root: {
                HomeView()
            })
        }
    }

    struct HomeView: View {
        @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator!

        var body: some View {
            Button(
                "Navigate",
                action: { navigationStackCoordinator.path.append(DestinationParameters()) }
            )
            .applyModifier({
#if !(os(macOS) || os(tvOS))
                $0.inlineNavigationTitle("Home")
#else
                $0
#endif
            })
            .navigationDestination(for: DestinationParameters.self, destination: DestinationView.init)
        }
    }

    struct DestinationParameters: Hashable {}

    struct DestinationView: View {
        private let parameters: DestinationParameters

        init(parameters: DestinationParameters) {
            self.parameters = parameters
        }

        var body: some View {
            Text("Destination")
                .applyModifier({
#if !(os(macOS) || os(tvOS))
                    $0.inlineNavigationTitle("Destination")
#else
                    $0
#endif
                })
        }
    }

    return ContentView()
})

#endif
