//
//  ModalPresenterRootModalData_Window.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.05.25.
//

#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))

import SwiftUI

// MARK: - Modal Presenter Root Modal Data (Window)
struct ModalPresenterRootModalData_Window: Identifiable {
    let id: String
    var uiModel: ModalPresenterLinkUIModel
    var view: () -> AnyView
    let presentationMode: ModalPresenterPresentationMode
}

#endif
