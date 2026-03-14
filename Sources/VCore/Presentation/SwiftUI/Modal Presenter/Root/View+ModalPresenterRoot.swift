//
//  View+ModalPresenterRoot.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.07.24.
//

import SwiftUI

extension View {
    /// Injects Modal Presenter root in view hierarchy for modal presentation.
    ///
    /// For additional info, refer to `View.modalPresenterLink(...)`.
    public func modalPresenterRoot(
        root: ModalPresenterRoot = .init(),
        appearance: ModalPresenterRootAppearance = .init()
    ) -> some View {
        self
            .modifier(
                ModalPresenterRootViewModifier(
                    root: root,
                    appearance: appearance
                )
            )
    }
}
