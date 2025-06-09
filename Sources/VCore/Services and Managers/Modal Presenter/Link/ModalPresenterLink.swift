//
//  ModalPresenterLink.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.05.25.
//

import Foundation

// MARK: - Modal Presenter Link
/// Modal Presenter link.
public struct ModalPresenterLink: Sendable {
    // MARK: Properties
    let storage: Storage
    
    /// Root ID.
    public var rootID: String? {
        switch storage {
        case .overlay(let rootID, _): rootID
        case .window(let rootID, _): rootID
        }
    }
    
    /// Link ID.
    public var linkID: String {
        switch storage {
        case .overlay(_, let linkID): linkID
        case .window(_, let linkID): linkID
        }
    }
    
    // MARK: Initializers
    private init(
        _ storage: Storage
    ) {
        self.storage = storage
    }
    
    /// Overlay configuration will present modals over current `SwiftUI` context using `View.overlay(...)` modifier.
    public static func overlay(
        rootID: String? = nil,
        linkID: String
    ) -> Self {
        self.init(
            .overlay(
                rootID: rootID,
                linkID: linkID
            )
        )
    }
    
    /// Window configuration will present modals in a new `UIWindow`.
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    public static func window(
        rootID: String? = nil,
        linkID: String
    ) -> Self {
        self.init(
            .window(
                rootID: rootID,
                linkID: linkID
            )
        )
    }
    
    // MARK: Storage
    enum Storage: Sendable {
        case overlay(rootID: String?, linkID: String)
        
        @available(macOS, unavailable)
        @available(tvOS, unavailable)
        @available(watchOS, unavailable)
        @available(visionOS, unavailable)
        case window(rootID: String?, linkID: String)
    }
}
