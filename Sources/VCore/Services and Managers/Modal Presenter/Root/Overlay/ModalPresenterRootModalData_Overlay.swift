//
//  ModalPresenterRootModalData_Overlay.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.05.25.
//

import SwiftUI

// MARK: - Modal Presenter Root Modal Data (Overlay)
struct ModalPresenterRootModalData_Overlay: Identifiable {
    let id: String
    var uiModel: ModalPresenterLinkUIModel
    var view: () -> AnyView
    let presentationMode: ModalPresenterPresentationMode
}
