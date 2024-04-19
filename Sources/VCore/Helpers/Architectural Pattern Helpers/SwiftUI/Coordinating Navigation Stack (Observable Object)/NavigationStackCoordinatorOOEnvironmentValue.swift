//
//  NavigationStackCoordinatorEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Navigation Stack Coordinator Environment Value (Observable Object)
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension EnvironmentValues {
    /// `NavigationStackCoordinatorOO` of the `View` associated with the environment.
    ///
    /// Since `NavigationStackCoordinatorOO` is a reference type, `View` updates won't be triggered.
    @EnvironmentValueGeneration public var navigationStackCoordinatorOO: NavigationStackCoordinatorOO?
}
