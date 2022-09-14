//
//  EnvironmentValues.NavigationStackCoordinator.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

#if !os(macOS) // TODO: Support macOS on release of 13.0

import SwiftUI

// MARK: - Environment Values Navigation Stack Coordinator
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

#endif
