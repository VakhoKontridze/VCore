//
//  PresentationHostSafeAreaInsetsEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.07.24.
//

import SwiftUI

// MARK: - Presentation Host Safe Area Insets Environment Value
extension EnvironmentValues {
    /// Presentation Host's safe area insets associated with the environment.
    @EnvironmentValueGeneration public var presentationHostSafeAreaInsets: EdgeInsets = .init()
}
