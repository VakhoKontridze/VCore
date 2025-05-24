//
//  PresentationHostInternalPresentationModeRegistrar.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.07.24.
//

import SwiftUI

// MARK: - Presentation Host Internal Presentation Mode Registrar
final class PresentationHostInternalPresentationModeRegistrar: @unchecked Sendable {
    // MARK: Properties - Singleton
    static let shared: PresentationHostInternalPresentationModeRegistrar = .init()
    
    // MARK: Properties - Registrar
    private var _registrar: [String?: PresentationHostInternalPresentationMode] = [
        nil: PresentationHostInternalPresentationMode()
    ]
    
    private var registrar: [String?: PresentationHostInternalPresentationMode] {
        get { lock.withLock({ _registrar }) }
        set { lock.withLock({ _registrar = newValue }) }
    }
    
    // MARK: Properties - Lock
    private let lock: NSLock = .init()

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
