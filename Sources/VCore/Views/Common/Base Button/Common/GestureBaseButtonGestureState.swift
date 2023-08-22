//
//  GestureBaseButtonGestureState.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Gesture Base Button Gesture State
/// Enum Enumeration that represents state, such as `possible`, `began`, `ended`, or `cancelled`.
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public enum GestureBaseButtonGestureState: Int, CaseIterable {
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
#if canImport(UIKit) && !os(watchOS)
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
#elseif canImport(AppKit)
    init(state: NSGestureRecognizer.State) {
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
#endif
}
