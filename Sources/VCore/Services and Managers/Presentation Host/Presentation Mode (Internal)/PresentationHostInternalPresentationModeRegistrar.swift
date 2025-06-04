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
    private var storage: [String?: PresentationHostInternalPresentationMode] = [:]
    
    // MARK: Properties - Queue
    // Queue cannot be used on properties as this method does both get and set operations
    private let queue: DispatchQueue = .init(
        label: "com.vakhtang-kontridze.vcore.presentation-host-internal-presentation-mode-registrar",
        attributes: .concurrent
    )

    // MARK: Initializers
    private init() {}

    // MARK: Resolution
    func resolve(
        layerID: String?
    ) -> PresentationHostInternalPresentationMode {
        queue.sync(flags: .barrier, execute: {
            if let internalPresentationMode: PresentationHostInternalPresentationMode = storage[layerID] {
                return internalPresentationMode

            } else {
                let internalPresentationMode: PresentationHostInternalPresentationMode = .init()
                storage[layerID] = internalPresentationMode
                return internalPresentationMode
            }
        })
    }
}
