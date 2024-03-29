//
//  PresentationHostPresentationModeEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import SwiftUI

// MARK: - Presentation Host Presentation Mode Extension
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension View {
    func presentationHostPresentationMode(
        _ presentationHostPresentationMode: PresentationHostPresentationMode?
    ) -> some View {
        self
            .environment(\.presentationHostPresentationMode, presentationHostPresentationMode)
    }
}

// MARK: - Presentation Host Presentation Mode Environment Value
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension EnvironmentValues {
    /// Presentation Host's presentation mode of the `View` associated with the environment.
    public var presentationHostPresentationMode: PresentationHostPresentationMode? {
        get { self[PresentationHostPresentationModeEnvironmentKey.self] }
        set { self[PresentationHostPresentationModeEnvironmentKey.self] = newValue }
    }
}

// MARK: - Presentation Host Presentation Mode Environment Key
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
private struct PresentationHostPresentationModeEnvironmentKey: EnvironmentKey {
    static let defaultValue: PresentationHostPresentationMode? = nil
}
