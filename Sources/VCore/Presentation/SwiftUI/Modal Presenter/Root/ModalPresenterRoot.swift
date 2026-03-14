//
//  ModalPresenterRoot.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.05.25.
//

import Foundation

/// Modal Presenter root.
public nonisolated struct ModalPresenterRoot: Sendable {
    // MARK: Properties
    /// Root ID.
    public let rootID: String?
    
    // MARK: Initializers
    /// Initializes `ModalPresenterRoot`.
    public init(
        rootID: String? = nil
    ) {
        self.rootID = rootID
    }
}
