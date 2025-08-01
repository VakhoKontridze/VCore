//
//  EnvironmentValue+ModalPresenterSafeAreaInsets.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.07.24.
//

import SwiftUI

extension EnvironmentValues {
    /// Modal Presenter's safe area insets associated with the environment.
    @Entry public var modalPresenterSafeAreaInsets: EdgeInsets = .init()
}
