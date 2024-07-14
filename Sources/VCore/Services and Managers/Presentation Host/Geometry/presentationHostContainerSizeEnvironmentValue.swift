//
//  PresentationHostContainerSizeEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.07.24.
//

import SwiftUI

// MARK: - Presentation Host Container Size Environment Value
extension EnvironmentValues {
    /// Presentation Host's container size associated with the environment.
    @EnvironmentValueGeneration public var presentationHostContainerSize: CGSize = .zero
}
