//
//  EnvironmentValues+ModalPresenterPresentationMode.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import SwiftUI

// MARK: - Environment Values + Modal Presenter Presentation Mode
extension EnvironmentValues {
    /// Modal Presenter's presentation mode of the `View` associated with the environment.
    @Entry public var modalPresenterPresentationMode: ModalPresenterPresentationMode?
}
