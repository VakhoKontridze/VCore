//
//  NavigationStackCoordinatorEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.09.23.
//

import SwiftUI

// MARK: - Navigation Stack Coordinator Extension
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension View {
    func navigationStackCoordinator(
        _ navigationStackCoordinator: NavigationStackCoordinator
    ) -> some View {
        self
            .environment(\.navigationStackCoordinator, navigationStackCoordinator)
    }
}

// MARK: - Navigation Stack Coordinator Environment Value
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension EnvironmentValues {
    /// `NavigationStackCoordinator` of the `View` associated with the environment.
    public var navigationStackCoordinator: NavigationStackCoordinator? {
        get { self[NavigationStackCoordinatorEnvironmentKey.self] }
        set { self[NavigationStackCoordinatorEnvironmentKey.self] = newValue }
    }
}

// MARK: - Navigation Stack Coordinator Environment Key
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
private struct NavigationStackCoordinatorEnvironmentKey: EnvironmentKey {
    static let defaultValue: NavigationStackCoordinator? = nil
}
