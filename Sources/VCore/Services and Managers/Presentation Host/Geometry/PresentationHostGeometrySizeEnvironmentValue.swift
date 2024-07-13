//
//  PresentationHostGeometrySizeEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.07.24.
//

import SwiftUI

// MARK: - Presentation Host Geometry Size Environment Value
extension EnvironmentValues {
    /// Presentation Host's geometry size associated with the environment.
    @EnvironmentValueGeneration public var presentationHostGeometrySize: CGSize = .zero
}
