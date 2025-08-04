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
    let updateSubject: PassthroughSubject<UpdateData, Never> = .init()
    let dismissSubject: PassthroughSubject<DismissData, Never> = .init()

    // MARK: Initializers
    init() {}
    
    // MARK: Types
    struct PresentationData {
        let link: ModalPresenterLink
        let appearance: ModalPresenterLinkAppearance
        let view: () -> AnyView
        let completion: () -> Void
    }

    struct UpdateData {
        let link: ModalPresenterLink
        let appearance: ModalPresenterLinkAppearance
        let view: () -> AnyView
    }
    
    struct DismissData {
        let link: ModalPresenterLink
        let completion: () -> Void
    }
}
