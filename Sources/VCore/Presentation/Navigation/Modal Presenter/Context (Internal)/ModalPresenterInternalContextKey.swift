//
//  ModalPresenterInternalContextKey.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.05.25.
//

import Foundation

nonisolated struct ModalPresenterInternalContextKey {
    // MARK: Properties
    let value: String
    
    // MARK: Initializers
    private init(
        rootID: String?
    ) {
        self.value = {
            if let rootID {
                "root-\(rootID)"
            } else {
                "root"
            }
        }()
    }
    
    init(root: ModalPresenterRoot) {
        self.init(
            rootID: root.rootID
        )
    }
    
    init(link: ModalPresenterLink) {
        self.init(
            rootID: link.rootID
        )
    }
}
