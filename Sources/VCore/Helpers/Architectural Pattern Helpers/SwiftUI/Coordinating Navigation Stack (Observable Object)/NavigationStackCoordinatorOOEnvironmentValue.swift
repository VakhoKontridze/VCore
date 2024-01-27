//
//  NavigationStackCoordinatorEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Navigation Stack Coordinator Extension (Observable Object)
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension View {
    func navigationStackCoordinatorOO(
        _ navigationStackCoordinator: NavigationStackCoordinatorOO
    ) -> some View {
        self
            .environment(\.navigationStackCoordinatorOO, navigationStackCoordinator)
    }
}

// MARK: - Navigation Stack Coordinator Environment Value (Observable Object)
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension EnvironmentValues {
    /// `NavigationStackCoordinatorOO` of the `View` associated with the environment.
    ///
    /// Since `NavigationStackCoordinatorOO` is a reference type, `View` updates won't be triggered.
    public var navigationStackCoordinatorOO: NavigationStackCoordinatorOO? {
        get { self[NavigationStackCoordinatorOOEnvironmentKey.self] }
        set { self[NavigationStackCoordinatorOOEnvironmentKey.self] = newValue }
    }
}

// MARK: - Navigation Stack Coordinator Environment Key (Observable Object)
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
private struct NavigationStackCoordinatorOOEnvironmentKey: EnvironmentKey {
    static let defaultValue: NavigationStackCoordinatorOO? = nil
}
