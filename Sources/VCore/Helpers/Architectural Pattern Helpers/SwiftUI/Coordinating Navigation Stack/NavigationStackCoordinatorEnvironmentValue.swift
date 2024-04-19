//
//  NavigationStackCoordinatorEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.09.23.
//

import SwiftUI

// MARK: - Navigation Stack Coordinator Environment Value
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension EnvironmentValues {
    /// `NavigationStackCoordinator` of the `View` associated with the environment.
    @EnvironmentValueGeneration public var navigationStackCoordinator: NavigationStackCoordinator?
}
