//
//  BaseButtonGestureState.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if os(iOS)

import Foundation

// MARK: - Base Button Gesture State
/// Enum that describes state, such as `none`, `press`, or `click`.
public enum BaseButtonGestureState: Int, CaseIterable {
    // MARK: Cases
    /// None.
    case none
    
    /// Press.
    ///
    /// Indicates if button is being pressed.
    case press
    
    /// Click.
    ///
    /// Indicates if successful click occurred.
    case click
    
    // MARK: Properties
    /// Indicates if button is being pressed.
    public var isPressed: Bool {
        switch self {
        case .none: return false
        case .press: return true
        case .click: return false
        }
    }
    
    /// Indicates if successful click occurred.
    public var isClicked: Bool {
        switch self {
        case .none: return false
        case .press: return false
        case .click: return true
        }
    }
}

#endif
