//
//  ModalPresenterInternalPresentationModeKey.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.05.25.
//

import Foundation

// MARK: - Modal Presenter Internal Presentation Mode Key
struct ModalPresenterInternalPresentationModeKey {
    // MARK: Properties
    let value: String
    
    // MARK: Initializers
    private init(
        type: Type_,
        rootID: String?
    ) {
        let prefix: String = {
            switch type {
            case .overlay: "overlay"
            case .window: "window"
            }
        }()
        
        self.value = {
            if let rootID {
                return "\(prefix)-\(rootID)"
            } else {
                return prefix
            }
        }()
    }
    
    init(root: ModalPresenterRoot) {
        self.init(
            type: {
                switch root.storage {
                case .overlay: .overlay
                case .window: .window
                }
            }(),
            rootID: {
                switch root.storage {
                case .overlay(let rootID): rootID
                case .window(let rootID): rootID
                }
            }()
        )
    }
    
    init(link: ModalPresenterLink) {
        self.init(
            type: {
                switch link.storage {
                case .overlay: .overlay
                case .window: .window
                }
            }(),
            rootID: {
                switch link.storage {
                case .overlay(let rootID, _): rootID
                case .window(let rootID, _): rootID
                }
            }()
        )
    }
    
    // MARK: Type
    private enum Type_ {
        case overlay
        case window
    }
}
