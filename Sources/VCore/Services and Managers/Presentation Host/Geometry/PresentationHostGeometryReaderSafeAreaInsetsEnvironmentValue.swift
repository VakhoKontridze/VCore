//
//  PresentationHostGeometryReaderSafeAreaInsetsEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.08.23.
//

import SwiftUI

// MARK: - Presentation Host Geometry Reader Safe Area Insets Extension
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension View {
    func presentationHostGeometryReaderSafeAreaInsets(
        _ presentationHostGeometryReaderSafeAreaInsets: EdgeInsets
    ) -> some View {
        self
            .environment(\.presentationHostGeometryReaderSafeAreaInsets, presentationHostGeometryReaderSafeAreaInsets)
    }
}

// MARK: - Presentation Host Geometry Reader Safe Area Insets Environment Value
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension EnvironmentValues {
    /// Presentation Host's `GeometryReader` safe area insets associated with the environment.
    public var presentationHostGeometryReaderSafeAreaInsets: EdgeInsets {
        get { self[PresentationHostGeometryReaderSafeAreaInsetsEnvironmentKey.self] }
        set { self[PresentationHostGeometryReaderSafeAreaInsetsEnvironmentKey.self] = newValue }
    }
}

// MARK: - Presentation Host Geometry Reader Safe Area Insets Environment Key
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
struct PresentationHostGeometryReaderSafeAreaInsetsEnvironmentKey: EnvironmentKey {
    static let defaultValue: EdgeInsets = .init()
}
