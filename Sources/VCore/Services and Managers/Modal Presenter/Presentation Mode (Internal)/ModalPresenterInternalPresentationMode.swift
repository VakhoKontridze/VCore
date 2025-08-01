//
//  ModalPresenterInternalPresentationMode.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.07.24.
//

import SwiftUI
import Combine

struct ModalPresenterInternalPresentationMode {
    // MARK: Properties
    let presentSubject: PassthroughSubject<PresentationData, Never> = .init()
    struct PresentationData {
        let link: ModalPresenterLink
        let appearance: ModalPresenterLinkAppearance
        let view: () -> AnyView
        let completion: () -> Void
    }

    let updateSubject: PassthroughSubject<UpdateData, Never> = .init()
    struct UpdateData {
        let link: ModalPresenterLink
        let appearance: ModalPresenterLinkAppearance
        let view: () -> AnyView
    }

    let dismissSubject: PassthroughSubject<DismissData, Never> = .init()
    struct DismissData {
        let link: ModalPresenterLink
        let completion: () -> Void
    }

    // MARK: Initializers
    init() {}
}
