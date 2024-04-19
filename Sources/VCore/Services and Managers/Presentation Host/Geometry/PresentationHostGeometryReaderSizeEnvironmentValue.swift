//
//  PresentationHostGeometryReaderSizeEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.08.23.
//

import SwiftUI

// MARK: - Presentation Host Geometry Reader Size Environment Value
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension EnvironmentValues {
    /// Presentation Host's `GeometryReader` size associated with the environment.
    @EnvironmentValueGeneration public var presentationHostGeometryReaderSize: CGSize = .zero
}
