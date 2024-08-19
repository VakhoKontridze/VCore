//
//  EnvironmentValues+NavigationStackCoordinatorOO.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Environment Values + Navigation Stack Coordinator (Observable Object)
extension EnvironmentValues {
    /// `NavigationStackCoordinatorOO` of the `View` associated with the environment.
    ///
    /// Since `NavigationStackCoordinatorOO` is a reference type, `View` updates won't be triggered.
    @EnvironmentValueGeneration public var navigationStackCoordinatorOO: NavigationStackCoordinatorOO?
}
