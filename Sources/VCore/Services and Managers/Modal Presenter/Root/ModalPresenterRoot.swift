//
//  ModalPresenterRoot.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.05.25.
//

import Foundation

// MARK: - Modal Presenter Root
/// Modal Presenter root.
public struct ModalPresenterRoot: Sendable {
    // MARK: Properties
    let storage: Storage
    
    /// Root ID.
    public var rootID: String? {
        switch storage {
        case .overlay(let rootID): rootID
        case .window(let rootID): rootID
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
        rootID: String? = nil
    ) -> Self {
        self.init(
            .overlay(
                rootID: rootID
            )
        )
    }
    
    /// Window configuration will present modals in a new `UIWindow`.
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    public static func window(
        rootID: String? = nil
    ) -> Self {
        self.init(
            .window(
                rootID: rootID
            )
        )
    }
    
    // MARK: Storage
    enum Storage {
        case overlay(rootID: String?)
        
        @available(macOS, unavailable)
        @available(tvOS, unavailable)
        @available(watchOS, unavailable)
        @available(visionOS, unavailable)
        case window(rootID: String?)
    }
}
