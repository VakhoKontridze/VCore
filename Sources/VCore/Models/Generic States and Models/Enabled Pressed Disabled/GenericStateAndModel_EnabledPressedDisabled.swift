//
//  GenericStateAndModel_EnabledPressedDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Pressed, Disabled)
/// Enumeration that represents state, such as `enabled`, `pressed`, or `disabled`.
///
/// Used for mapping state to `GenericStateModel_EnabledPressedDisabled`, via `value(for:)` method.
public enum GenericState_EnabledPressedDisabled: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if gesture is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .enabled: true
        case .pressed: true
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_EnabledPressedDisabled` with flags.
    public init(isEnabled: Bool, isPressed: Bool) {
        switch (isEnabled, isPressed) {
        case (false, _): self = .disabled
        case (true, false): self = .enabled
        case (true, true): self = .pressed
        }
    }
}

// MARK: - Generic State Model (Enabled, Pressed, Disabled)
/// Value group containing generic `enabled`, `pressed`, and `disabled` values.
///
/// Used for mapping `GenericState_EnabledPressedDisabled` to model, via `value(for:)` method.
public struct GenericStateModel_EnabledPressedDisabled<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Pressed value.
    public var pressed: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EnabledPressedDisabled` with values.
    public init(
        enabled: Value,
        pressed: Value,
        disabled: Value
    ) {
        self.enabled = enabled
        self.pressed = pressed
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_EnabledPressedDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_EnabledPressedDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledPressedDisabled<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_EnabledPressedDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledPressedDisabled<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializers
#if canImport(UIKit)

import UIKit

extension GenericStateModel_EnabledPressedDisabled {
    /// Initializes `GenericStateModel_EnabledPressedDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledPressedDisabled<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_EnabledPressedDisabled {
    /// Initializes `GenericStateModel_EnabledPressedDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledPressedDisabled<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_EnabledPressedDisabled {
    /// Initializes `GenericStateModel_EnabledPressedDisabled` with `GenericStateModel_EnabledPressedLoadingDisabled`.
    public init(_ model: GenericStateModel_EnabledPressedLoadingDisabled<Value>) {
        self.init(
            enabled: model.enabled,
            pressed: model.pressed,
            disabled: model.disabled
        )
    }
    
    /// Initializes `GenericStateModel_EnabledPressedDisabled` with `GenericStateModel_EnabledPressedFocusedDisabled`.
    public init(_ model: GenericStateModel_EnabledPressedFocusedDisabled<Value>) {
        self.init(
            enabled: model.enabled,
            pressed: model.pressed,
            disabled: model.disabled
        )
    }
}

// MARK: Equatable, Hashable, Comparable
extension GenericStateModel_EnabledPressedDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_EnabledPressedDisabled: Hashable where Value: Hashable {}

extension GenericStateModel_EnabledPressedDisabled: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.pressed, \.disabled)
    }
}

// MARK: - Mapping
extension GenericStateModel_EnabledPressedDisabled {
    /// Maps `GenericState_EnabledPressedDisabled` to `GenericStateModel_EnabledPressedDisabled`.
    public func value(for state: GenericState_EnabledPressedDisabled) -> Value {
        switch state {
        case .enabled: enabled
        case .pressed: pressed
        case .disabled: disabled
        }
    }
}
