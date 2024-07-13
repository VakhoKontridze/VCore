//
//  PresentationHostInternalPresentationModeRegistrar.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.07.24.
//

import SwiftUI

// MARK: - Presentation Host Internal Presentation Mode Registrar
final class PresentationHostInternalPresentationModeRegistrar {
    // MARK: Properties
    private var registrar: [String?: PresentationHostInternalPresentationMode] = [
        nil: PresentationHostInternalPresentationMode()
    ]

    static let shared: PresentationHostInternalPresentationModeRegistrar = .init()

    // MARK: Initializers
    private init() {}

    // MARK: Resolution
    func resolve(
        layerID: String?
    ) -> PresentationHostInternalPresentationMode {
        if let internalPresentationMode: PresentationHostInternalPresentationMode = registrar[layerID] {
            return internalPresentationMode

        } else {
            let internalPresentationMode: PresentationHostInternalPresentationMode = .init()
            registrar[layerID] = internalPresentationMode
            return internalPresentationMode
        }
    }
}
