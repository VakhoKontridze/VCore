//
//  BaseButtonState.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation

// MARK: - UIKit Base Button State
/// Enum Enumeration that represents state, such as `enabled` or `disabled`.
@available(tvOS, unavailable)
public enum UIKitBaseButtonState: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if UIKitBaseButtonState is enabled.
    public var isEnabled: Bool {
        switch self {
        case .enabled: return true
        case .disabled: return false
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

// MARK: - UIKit Base Button Internal State
/// Enum Enumeration that represents state, such as `enabled`, `pressed`, or `disabled`.
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
    public var isEnabled: Bool {
        switch self {
        case .enabled: return true
        case .pressed: return true
        case .disabled: return false
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

// MARK: - Mapping
@available(tvOS, unavailable)
extension GenericStateModel_EnabledPressedDisabled {
    /// Maps `UIKitBaseButtonInternalState` to `GenericStateModel_EnabledPressedDisabled`.
    public func value(for state: UIKitBaseButtonInternalState) -> Value {
        switch state {
        case .enabled: return enabled
        case .pressed: return pressed
        case .disabled: return disabled
        }
    }
}

#endif
