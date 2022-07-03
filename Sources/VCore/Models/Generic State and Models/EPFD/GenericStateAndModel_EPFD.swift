//
//  GenericStateAndModel_EPFD.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 3/10/22.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Pressed, Focused, Disabled)
/// Enumeration that represents state, such as `enabled`, `pressed`, `focused`, or `disabled`.
///
/// Used for mapping state to `GenericStateModel_EPFD`, via `value(for:)` method.
public enum GenericState_EPFD: Int, CaseIterable {
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
    /// Indicates if interaction is enabled.
    public var isEnabled: Bool {
        switch self {
        case .enabled: return true
        case .pressed: return true
        case .focused: return true
        case .disabled: return false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_EPFD` with flags.
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
/// Used for mapping `GenericState_EPFD` to model, via `value(for:)` method.
public struct GenericStateModel_EPFD<Value> {
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
    /// Initializes `GenericStateModel_EPFD` with values.
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
    
    /// Initializes `GenericStateModel_EPFD` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
        self.focused = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_EPFD` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EPFD<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_EPFD` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EPFD<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_EPFD {
    /// Initializes `GenericStateModel_EPFD` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EPFD<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_EPFD {
    /// Initializes `GenericStateModel_EPFD` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EPFD<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_EPFD: Hashable where Value: Hashable {}

extension GenericStateModel_EPFD: Equatable where Value: Equatable {}

extension GenericStateModel_EPFD: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.pressed, \.focused, \.disabled)
    }
}

// MARK: - Mapping
extension GenericStateModel_EPFD {
    /// Maps `GenericState_EPFD` to `GenericStateModel_EPFD`.
    public func value(for state: GenericState_EPFD) -> Value {
        switch state {
        case .enabled: return enabled
        case .pressed: return pressed
        case .focused: return focused
        case .disabled: return disabled
        }
    }
}
