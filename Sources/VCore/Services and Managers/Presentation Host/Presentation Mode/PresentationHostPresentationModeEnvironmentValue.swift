//
//  PresentationHostPresentationModeEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import SwiftUI

// MARK: - Presentation Host Presentation Mode Environment Value
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension EnvironmentValues {
    /// Presentation Host's presentation mode of the `View` associated with the environment.
    @EnvironmentValueGeneration public var presentationHostPresentationMode: PresentationHostPresentationMode?
}
