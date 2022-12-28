//
//  EnvironmentValues.NavigationStackCoordinator.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Environment Values Navigation Stack Coordinator
@available(iOS 16.0, *)
@available(macOS 13.0, *)
@available(tvOS 16.0, *)
@available(watchOS 9.0, *)
extension EnvironmentValues {
    /// `NavigationStackCoordinator` of the view associated with the environment.
    ///
    ///     @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator?
    ///
    ///     var body: some View {
    ///         CoordinatingNavigationStack(root: {
    ///             content
    ///         })
    ///     }
    ///
    public var navigationStackCoordinator: NavigationStackCoordinator? {
        get { self[NavigationStackCoordinatorEnvironmentKey.self] }
        set { self[NavigationStackCoordinatorEnvironmentKey.self] = newValue }
    }
}

@available(iOS 16.0, *)
@available(macOS 13.0, *)
@available(tvOS 16.0, *)
@available(watchOS 9.0, *)
struct NavigationStackCoordinatorEnvironmentKey: EnvironmentKey {
    static var defaultValue: NavigationStackCoordinator? = nil
}
