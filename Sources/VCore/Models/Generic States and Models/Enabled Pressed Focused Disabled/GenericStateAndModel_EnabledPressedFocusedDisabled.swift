//
//  GenericStateAndModel_EnabledPressedFocusedDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 3/10/22.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Genetic State (Enabled, Pressed, Focused, Disabled)
/// Enumeration that represents state, such as `enabled`, `pressed`, `focused`, or `disabled`.
///
/// Used for mapping state to `GenericStateModel_EnabledPressedFocusedDisabled`, with `value(for:)` method.
public enum GenericState_EnabledPressedFocusedDisabled: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    /// Focused.
    case focused
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if gesture is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .enabled: true
        case .pressed: true
        case .focused: true
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_EnabledPressedFocusedDisabled` with flags.
    public init(isEnabled: Bool, isPressed: Bool, isFocused: Bool) {
        switch (isEnabled, isPressed, isFocused) {
        case (false, _, _): self = .disabled
        case (true, false, false): self = .enabled
        case (true, true, false): self = .pressed
        case (true, _, true): self = .focused
        }
    }
}

// MARK: - Generic State Model (Enabled, Pressed, Focused, Disabled)
/// Value group containing generic `enabled`, `pressed`, `focused`, and `disabled` values.
///
/// Used for mapping `GenericState_EnabledPressedFocusedDisabled` to model, with `value(for:)` method.
public struct GenericStateModel_EnabledPressedFocusedDisabled<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Pressed value.
    public var pressed: Value
    
    /// Focused value.
    public var focused: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EnabledPressedFocusedDisabled` with values.
    public init(
        enabled: Value,
        pressed: Value,
        focused: Value,
        disabled: Value
    ) {
        self.enabled = enabled
        self.pressed = pressed
        self.focused = focused
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_EnabledPressedFocusedDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
        self.focused = value
        self.disabled = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_EnabledPressedFocusedDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledPressedFocusedDisabled<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_EnabledPressedFocusedDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledPressedFocusedDisabled<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_EnabledPressedFocusedDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledPressedFocusedDisabled<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_EnabledPressedFocusedDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledPressedFocusedDisabled<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Map
    /// Returns `GenericStateModel_EnabledPressedFocusedDisabled`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            enabled: try transform(enabled),
            pressed: try transform(pressed),
            focused: try transform(focused),
            disabled: try transform(disabled)
        )
    }
}

// MARK: Equatable, Hashable
extension GenericStateModel_EnabledPressedFocusedDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_EnabledPressedFocusedDisabled: Hashable where Value: Hashable {}

// MARK: - State-Model Mapping
extension GenericStateModel_EnabledPressedFocusedDisabled {
    /// Maps `GenericState_EnabledPressedFocusedDisabled` to `GenericStateModel_EnabledPressedFocusedDisabled`.
    public func value(for state: GenericState_EnabledPressedFocusedDisabled) -> Value {
        switch state {
        case .enabled: enabled
        case .pressed: pressed
        case .focused: focused
        case .disabled: disabled
        }
    }
}
