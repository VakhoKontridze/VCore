//
//  PresentationHostInternalPresentationMode.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.07.24.
//

import SwiftUI
import Combine

// MARK: - Presentation Host Internal Presentation Mode
final class PresentationHostInternalPresentationMode: ObservableObject {
    // MARK: Properties
    let presentPublisher: PassthroughSubject<PresentationData, Never> = .init()
    struct PresentationData: Identifiable {
        let id: String
        let view: () -> AnyView
        let completion: () -> Void
    }

    let updatePublisher: PassthroughSubject<UpdateData, Never> = .init()
    struct UpdateData {
        let id: String
        let view: () -> AnyView
    }

    let dismissPublisher: PassthroughSubject<DismissData, Never> = .init()
    struct DismissData {
        let id: String
        let completion: () -> Void
    }

    // MARK: Initializers
    init() {}
}
