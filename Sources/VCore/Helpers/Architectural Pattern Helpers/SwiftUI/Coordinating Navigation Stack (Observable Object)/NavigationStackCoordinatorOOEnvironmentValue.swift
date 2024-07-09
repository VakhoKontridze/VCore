//
//  NavigationStackCoordinatorEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Navigation Stack Coordinator Environment Value (Observable Object)
extension EnvironmentValues {
    /// `NavigationStackCoordinatorOO` of the `View` associated with the environment.
    ///
    /// Since `NavigationStackCoordinatorOO` is a reference type, `View` updates won't be triggered.
    @EnvironmentValueGeneration public var navigationStackCoordinatorOO: NavigationStackCoordinatorOO?
}
