//
//  EnvironmentValues+PresentationHostPresentationMode.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import SwiftUI

// MARK: - Environment Values + Presentation Host Presentation Mode
extension EnvironmentValues {
    /// Presentation Host's presentation mode of the `View` associated with the environment.
    @Entry public var presentationHostPresentationMode: PresentationHostPresentationMode?
}
