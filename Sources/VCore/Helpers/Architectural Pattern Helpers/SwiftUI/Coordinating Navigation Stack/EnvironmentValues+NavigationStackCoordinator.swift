//
//  EnvironmentValues+NavigationStackCoordinator.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.09.23.
//

import SwiftUI

// MARK: - Environment Values + Navigation Stack Coordinator
extension EnvironmentValues {
    /// `NavigationStackCoordinator` of the `View` associated with the environment.
    @Entry public var navigationStackCoordinator: NavigationStackCoordinator?
}
