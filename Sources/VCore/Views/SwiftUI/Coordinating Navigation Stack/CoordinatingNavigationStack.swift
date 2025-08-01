//
//  CoordinatingNavigationStack.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.09.23.
//

import SwiftUI

/// `NavigationStack` that manages `NavigationPath` for representing content in the stack.
///
/// `View` embeds `NavigationStackCoordinator` in the environment that can be used to by contents in the stack.
/// Can be used to push or pop `View`s programmatically.
///
///     var body: some View {
///         CoordinatingNavigationStack {
///             HomeView()
///                 .navigationDestination(for: DestinationParameters.self, destination: DestinationView.init)
///         }
///     }
///
///     struct HomeView: View {
///         @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator!
///
///         var body: some View {
///             Button("Navigate") {
///                 navigationStackCoordinator.path.append(DestinationParameters())
///             }
///         }
///     }
///
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
        self._navigationStackCoordinator = State(
            wrappedValue: NavigationStackCoordinator(
                path: navigationPath()
            )
        )
        self.root = root
    }

    /// Initializes `CoordinatingNavigationStack`.
    public init(
        path navigationPath: @escaping @autoclosure () -> NavigationPath,
        @ViewBuilder root: @escaping () -> Root
    ) {
        self._navigationStackCoordinator = State(
            wrappedValue: NavigationStackCoordinator(
                path: navigationPath()
            )
        )
        self.root = { _ in root() }
    }

    // MARK: Initializers - No NavigationPath
    /// Initializes `CoordinatingNavigationStack`.
    public init(
        @ViewBuilder root: @escaping (NavigationStackCoordinator) -> Root
    ) {
        self._navigationStackCoordinator = State(
            wrappedValue: NavigationStackCoordinator(
                path: NavigationPath()
            )
        )
        self.root = root
    }

    /// Initializes `CoordinatingNavigationStack`.
    public init(
        @ViewBuilder root: @escaping () -> Root
    ) {
        self._navigationStackCoordinator = State(
            wrappedValue: NavigationStackCoordinator(
                path: NavigationPath()
            )
        )
        self.root = { _ in root() }
    }

    // MARK: Body
    public var body: some View {
        NavigationStack(path: $navigationStackCoordinator.path) {
            root(navigationStackCoordinator)
        }
        .environment(\.navigationStackCoordinator, navigationStackCoordinator)
    }
}

#if DEBUG

#Preview {
    struct ContentView: View {
        // MARK: Body
        var body: some View {
            CoordinatingNavigationStack {
                HomeView()
                    .navigationDestination(for: DestinationParameters.self, destination: DestinationView.init)
            }
        }
    }

    struct HomeView: View {
        // MARK: Properties
        @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator!

        // MARK: Body
        var body: some View {
            Button("Navigate") {
                navigationStackCoordinator.path.append(DestinationParameters())
            }
#if !(os(macOS) || os(tvOS))
            .inlineNavigationTitle("Home")
#endif
        }
    }

    struct DestinationParameters: Hashable {}

    struct DestinationView: View {
        // MARK: Properties
        @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator!
        
        private let parameters: DestinationParameters

        // MARK: Initializers
        init(parameters: DestinationParameters) {
            self.parameters = parameters
        }

        // MARK: Body
        var body: some View {
            Button("Go Back") {
                navigationStackCoordinator.path.removeLast()
            }
#if !(os(macOS) || os(tvOS))
            .inlineNavigationTitle("Destination")
#endif
        }
    }

    return ContentView()
}

#endif
