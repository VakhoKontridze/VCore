//
//  EnvironmentValue+ModalPresenterInterfaceOrientation.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.07.25.
//

import SwiftUI

// MARK: - Environment Values + Modal Presenter Interface Orientation
extension EnvironmentValues {
    /// Modal Presenter's interface orientation associated with the environment.
    @Entry public var modalPresenterInterfaceOrientation: PlatformInterfaceOrientation = .portrait // `initFromDeviceOrientation()` cannot be used due to `MainActor`
}
