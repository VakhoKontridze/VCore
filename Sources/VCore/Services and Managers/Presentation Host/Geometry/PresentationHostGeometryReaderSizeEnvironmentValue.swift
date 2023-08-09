//
//  PresentationHostGeometryReaderSizeEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.08.23.
//

import SwiftUI

// MARK: - Presentation Host Geometry Reader Size Extension
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {
    func presentationHostGeometryReaderSize(
        _ presentationHostGeometryReaderSize: CGSize
    ) -> some View {
        self
            .environment(\.presentationHostGeometryReaderSize, presentationHostGeometryReaderSize)
    }
}

// MARK: - Presentation Host Geometry Reader Size Environment Value
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension EnvironmentValues {
    /// Presentation Host's `GeometryReader` size associated with the environment.
    public var presentationHostGeometryReaderSize: CGSize {
        get { self[PresentationHostGeometryReaderSizeEnvironmentKey.self] }
        set { self[PresentationHostGeometryReaderSizeEnvironmentKey.self] = newValue }
    }
}

// MARK: - Presentation Host Geometry Reader Size Environment Key
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
struct PresentationHostGeometryReaderSizeEnvironmentKey: EnvironmentKey {
    static var defaultValue: CGSize = .zero
}
