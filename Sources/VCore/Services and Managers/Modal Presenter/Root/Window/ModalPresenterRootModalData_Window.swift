//
//  ModalPresenterRootModalData_Window.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.05.25.
//

#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))

import SwiftUI

struct ModalPresenterRootModalData_Window: Identifiable {
    let id: String
    var appearance: ModalPresenterLinkAppearance
    var view: () -> AnyView
    let presentationMode: ModalPresenterPresentationMode
}

#endif
