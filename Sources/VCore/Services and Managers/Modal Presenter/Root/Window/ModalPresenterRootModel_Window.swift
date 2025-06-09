//
//  ModalPresenterRootModel_Window.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.05.25.
//

#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))

import SwiftUI

// MARK: - Modal Presenter Root Model (Window)
// Allows data to be shared between `ViewModifier` and `ModalContent` without re-setting `UIHostingController`'s `rootView`.
@Observable
@MainActor
final class ModalPresenterRootModel_Window {
    // MARK: Properties
    var uiModel: ModalPresenterRootUIModel
    var modals: [ModalPresenterRootModalData_Window] = []
    var safeAreaInsets: EdgeInsets! // Force-unwrap
    var keyboardObserver: KeyboardObserver
    
    // MARK: Initializers
    init(
        uiModel: ModalPresenterRootUIModel,
        keyboardObserver: KeyboardObserver
    ) {
        self.uiModel = uiModel
        self.keyboardObserver = keyboardObserver
    }
}

#endif
