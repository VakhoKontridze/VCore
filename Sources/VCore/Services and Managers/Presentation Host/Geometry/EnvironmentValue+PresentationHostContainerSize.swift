//
//  EnvironmentValues+PresentationHostContainerSize.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.07.24.
//

import SwiftUI

// MARK: - Environment Values + Presentation Host Container Size
extension EnvironmentValues {
    /// Presentation Host's container size associated with the environment.
    @EnvironmentValueGeneration public var presentationHostContainerSize: CGSize = .zero
}
