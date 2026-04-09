//
//  ModalPresenterInternalContextRegistrar.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.07.24.
//

import SwiftUI

final class ModalPresenterInternalContextRegistrar {
    // MARK: Properties - Singleton
    static let shared: ModalPresenterInternalContextRegistrar = .init()
    
    // MARK: Properties - Registrar
    private var registrar: [String: ModalPresenterInternalContext] = [:]

    // MARK: Initializers
    private init() {}

    // MARK: Resolution
    func resolve(
        key: ModalPresenterInternalContextKey
    ) -> ModalPresenterInternalContext {
        if let internalContext: ModalPresenterInternalContext = registrar[key.value] {
            return internalContext

        } else {
            let internalContext: ModalPresenterInternalContext = .init()
            registrar[key.value] = internalContext
            return internalContext
        }
    }
}
