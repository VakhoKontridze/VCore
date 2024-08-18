//
//  PresentationHostPresentationModeEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import SwiftUI

// MARK: - Presentation Host Presentation Mode Environment Value
extension EnvironmentValues {
    /// Presentation Host's presentation mode of the `View` associated with the environment.
    @EnvironmentValueGeneration public var presentationHostPresentationMode: PresentationHostPresentationMode?
}
