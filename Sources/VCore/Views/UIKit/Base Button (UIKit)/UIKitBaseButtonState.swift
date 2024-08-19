//
//  BaseButtonState.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation

// MARK: - UI Kit Base Button State
/// Enumeration that represents state.
@available(tvOS, unavailable)
public enum UIKitBaseButtonState: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if UIKitBaseButtonState is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .enabled: true
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `UIKitBaseButtonState` with flag.
    public init(isEnabled: Bool) {
        switch isEnabled {
        case false: self = .disabled
        case true: self = .enabled
        }
    }
    
    init(internalState: UIKitBaseButtonInternalState) {
        switch internalState {
        case .enabled: self = .enabled
        case .pressed: self = .enabled
        case .disabled: self = .disabled
        }
    }
}

// MARK: - UI Kit Base Button Internal State
/// Enumeration that represents state.
@available(tvOS, unavailable)
public enum UIKitBaseButtonInternalState: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if interaction is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .enabled: true
        case .pressed: true
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `UIKitBaseButtonInternalState` with flag.
    public init(isEnabled: Bool) {
        switch isEnabled {
        case false: self = .disabled
        case true: self = .enabled
        }
    }
    
    /// Initializes `UIKitBaseButtonInternalState` with flags.
    public init(isEnabled: Bool, isPressed: Bool) {
        switch (isEnabled, isPressed) {
        case (false, _): self = .disabled
        case (true, false): self = .enabled
        case (true, true): self = .pressed
        }
    }
    
    /// Default value for `UIKitBaseButtonInternalState`.
    public static var `default`: Self { .enabled }
}

// MARK: - State-Model Mapping
@available(tvOS, unavailable)
extension GenericStateModel_EnabledPressedDisabled {
    /// Maps `UIKitBaseButtonInternalState` to `GenericStateModel_EnabledPressedDisabled`.
    public func value(for state: UIKitBaseButtonInternalState) -> Value {
        switch state {
        case .enabled: enabled
        case .pressed: pressed
        case .disabled: disabled
        }
    }
}

#endif
