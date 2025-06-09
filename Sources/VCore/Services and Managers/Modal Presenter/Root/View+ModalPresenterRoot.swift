//
//  View+ModalPresenterRoot.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.07.24.
//

import SwiftUI

// MARK: - View + Modal Presenter Root
extension View {
    /// Injects Modal Presenter root in view hierarchy for modal presentation.
    ///
    /// For additional info, refer to `View.modalPresenterLink(...)`.
    @ViewBuilder
    public func modalPresenterRoot(
        root: ModalPresenterRoot,
        uiModel: ModalPresenterRootUIModel = .init()
    ) -> some View {
        switch root.storage {
        case .overlay:
            self
                .modifier(
                    ModalPresenterRootViewModifier_Overlay(
                        root: root,
                        uiModel: uiModel
                    )
                )
            
        case .window:
#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))
            self
                .modifier(
                    ModalPresenterRootViewModifier_Window(
                        root: root,
                        uiModel: uiModel,
                    )
                )
#else
            fatalError() // Not supported
#endif
        }
    }
}
