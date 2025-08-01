//
//  ModalPresenterRootModalData_Overlay.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.05.25.
//

import SwiftUI

struct ModalPresenterRootModalData_Overlay: Identifiable {
    let id: String
    var appearance: ModalPresenterLinkAppearance
    var view: () -> AnyView
    let presentationMode: ModalPresenterPresentationMode
}
