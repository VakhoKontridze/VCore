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
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public struct CoordinatingNavigationStack<Root>: View where Root: View {
    // MARK: Properties
    @StateObject private var navigationStackCoordinator: NavigationStackCoordinator
    private let root: (NavigationStackCoordinator) -> Root

    // MARK: Initializers
    /// Initializes `CoordinatingNavigationStack`.
    public init(
        path navigationPath: NavigationPath = .init(),
        @ViewBuilder root: @escaping (NavigationStackCoordinator) -> Root
    ) {
        self._navigationStackCoordinator = .init(wrappedValue: .init(path: navigationPath))
        self.root = root
    }
    
    /// Initializes `CoordinatingNavigationStack`.
    public init(
        path navigationPath: NavigationPath = .init(),
        @ViewBuilder root: @escaping () -> Root
    ) {
        self.init(
            path: navigationPath,
            root: { _ in root() }
        )
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

// MARK: - Navigation Stack Coordinator
/// `ObservableObject` that stores `NavigationPath` for coordinating with `CoordinatingNavigationStack`.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
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

// MARK: - Navigation Stack Coordinator Environment Value
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension EnvironmentValues {
    /// `NavigationStackCoordinator` of the view associated with the environment.`
    public var navigationStackCoordinator: NavigationStackCoordinator? {
        get { self[NavigationStackCoordinatorEnvironmentKey.self] }
        set { self[NavigationStackCoordinatorEnvironmentKey.self] = newValue }
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
struct NavigationStackCoordinatorEnvironmentKey: EnvironmentKey {
    static var defaultValue: NavigationStackCoordinator? = nil
}
