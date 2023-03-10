//
//  PresentationHostPresentationModeEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

#if os(iOS)

import SwiftUI

// MARK: - Presentation Host Presentation Mode Extension
extension View {
    func presentationHostPresentationMode(
        _ presentationHostExternalDismiss: PresentationHostPresentationMode
    ) -> some View {
        self
            .environment(\.presentationHostPresentationMode, presentationHostExternalDismiss)
    }
}

// MARK: - Presentation Host Presentation Mode Environment Value
extension EnvironmentValues {
    /// `PresentationHost` presentation mode of the view associated with the environment.
    public var presentationHostPresentationMode: PresentationHostPresentationMode {
        get { self[PresentationHostPresentationModeEnvironmentKey.self] }
        set { self[PresentationHostPresentationModeEnvironmentKey.self] = newValue }
    }
}

// MARK: - Presentation Host Presentation Mode Environment Key
private struct PresentationHostPresentationModeEnvironmentKey: EnvironmentKey {
    static let defaultValue: PresentationHostPresentationMode = .init()
}

#endif

