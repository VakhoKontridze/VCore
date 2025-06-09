//
//  ModalPresenterInternalPresentationModeRegistrar.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.07.24.
//

import SwiftUI

// MARK: - Modal Presenter Internal Presentation Mode Registrar
@MainActor
final class ModalPresenterInternalPresentationModeRegistrar {
    // MARK: Properties - Singleton
    static let shared: ModalPresenterInternalPresentationModeRegistrar = .init()
    
    // MARK: Properties - Registrar
    private var registrar: [String: ModalPresenterInternalPresentationMode] = [:]

    // MARK: Initializers
    private init() {}

    // MARK: Resolution
    func resolve(
        key: ModalPresenterInternalPresentationModeKey
    ) -> ModalPresenterInternalPresentationMode {
        if let internalPresentationMode: ModalPresenterInternalPresentationMode = registrar[key.value] {
            return internalPresentationMode

        } else {
            let internalPresentationMode: ModalPresenterInternalPresentationMode = .init()
            registrar[key.value] = internalPresentationMode
            return internalPresentationMode
        }
    }
}
