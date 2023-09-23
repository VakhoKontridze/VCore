//
//  NavigationStackCoordinatorEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Navigation Stack Coordinator Extension
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension View {
    func navigationStackCoordinator(
        _ navigationStackCoordinator: NavigationStackCoordinator
    ) -> some View {
        self
            .environment(\.navigationStackCoordinator, navigationStackCoordinator)
    }
}

// MARK: - Navigation Stack Coordinator Environment Value
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension EnvironmentValues {
    /// `NavigationStackCoordinator` of the `View` associated with the environment.
    ///
    /// Since `NavigationStackCoordinator` is a reference type, `View` updates won't be triggered.
    ///
    ///     @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator!
    ///
    ///     var body: some View {
    ///         CoordinatingNavigationStack(root: {
    ///             ...
    ///         })
    ///     }
    ///
    public var navigationStackCoordinator: NavigationStackCoordinator? {
        get { self[NavigationStackCoordinatorEnvironmentKey.self] }
        set { self[NavigationStackCoordinatorEnvironmentKey.self] = newValue }
    }
}

// MARK: - Navigation Stack Coordinator Environment Key
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
private struct NavigationStackCoordinatorEnvironmentKey: EnvironmentKey {
    static var defaultValue: NavigationStackCoordinator? = nil
}
