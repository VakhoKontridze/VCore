//
//  EnvironmentValue+PresentationHostSafeAreaInsets.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.07.24.
//

import SwiftUI

// MARK: - Environment Values + Presentation Host Safe Area Insets
extension EnvironmentValues {
    /// Presentation Host's safe area insets associated with the environment.
    @EnvironmentValueGeneration public var presentationHostSafeAreaInsets: EdgeInsets = .init()
}
