//
//  ModalPresenterLink.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.05.25.
//

import Foundation

/// Modal Presenter link.
public nonisolated struct ModalPresenterLink: Sendable {
    // MARK: Properties
    /// Root ID.
    public let rootID: String?
    
    /// Link ID.
    public let linkID: String
    
    // MARK: Initializers
    /// Initializes `ModalPresenterLink`.
    public init(
        rootID: String? = nil,
        linkID: String
    ) {
        self.rootID = rootID
        self.linkID = linkID
    }
}
