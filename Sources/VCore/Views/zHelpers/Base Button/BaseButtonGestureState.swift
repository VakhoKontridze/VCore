//
//  BaseButtonGestureState.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if os(iOS)

import UIKit

// MARK: - Base Button Gesture State
/// Enum that describes state, such as `possible`, `began`, `ended`, or `cancelled`.
public enum BaseButtonGestureState: Int, CaseIterable {
    /// Indicates that interaction is possible. This is a default state.
    case possible
    
    /// Indicates that interaction has began.
    case began
    
    /// Indicates that interaction ended and resulted in a successful click.
    ///
    /// State will reset to `possible`.
    case ended
    
    /// Indicates that interaction was cancelled.
    ///
    /// State will reset to `possible`.
    case cancelled
    
    // MARK: Properties
    /// Indicates if button is being pressed.
    public var isPressed: Bool {
        self == .began
    }
    
    /// Indicates if button recognized a successful click.
    public var isClicked: Bool {
        self == .ended
    }
    
    // MARK: Initializers
    init(state: UIGestureRecognizer.State) {
        self = {
            switch state {
            case .possible: return .possible
            case .began: return .began
            case .changed: fatalError() // Never used
            case .ended: return .ended
            case .cancelled: return .cancelled
            case .failed: fatalError() // Never used
            @unknown default: fatalError()
            }
        }()
    }
}

#endif
