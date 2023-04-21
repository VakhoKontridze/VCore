//
//  GenericStateAndModel_OffOnIndeterminatePressedDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 3/1/22.
//

import SwiftUI

// MARK: - Generic State (Off, On, Indeterminate, Pressed, Disabled)
/// Enumeration that represents state, such as `off`, `on`, `indeterminate`, `pressed` (`off`), `pressed` (`on`)`, `pressed` (`indeterminate`), or `disabled`.
///
/// Used for mapping state to `GenericStateModel_OffOnIndeterminatePressedDisabled`, via `value(for:)` method.
public enum GenericState_OffOnIndeterminatePressedDisabled: Int, CaseIterable {
    // MARK: Cases
    /// Off.
    case off
    
    /// On.
    case on
    
    /// Indeterminate.
    case indeterminate
    
    /// Pressed (off).
    case pressedOff
    
    /// Pressed (on).
    case pressedOn
    
    /// Pressed (indeterminate).
    case pressedIndeterminate
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if interaction is enabled.
    public var isEnabled: Bool {
        switch self {
        case .off: return true
        case .on: return true
        case .indeterminate: return true
        case .pressedOff: return true
        case .pressedOn: return true
        case .pressedIndeterminate: return true
        case .disabled: return false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_OffOnPressedDisabled` with flags.
    public init(isEnabled: Bool, state: GenericState_OffOnIndeterminate, isPressed: Bool) {
        switch (isEnabled, state, isPressed) {
        case (false, _, _): self = .disabled
        case (true, .off, false): self = .off
        case (true, .off, true): self = .pressedOff
        case (true, .on, false): self = .on
        case (true, .on, true): self = .pressedOn
        case (true, .indeterminate, false): self = .indeterminate
        case (true, .indeterminate, true): self = .pressedIndeterminate
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .off, .pressedOff: self = .on
        case .on, .pressedOn: self = .off
        case .indeterminate, .pressedIndeterminate: self = .on
        case .disabled: break
        }
    }
}

// MARK: - Generic State Model (Off, On, Indeterminate, Pressed, Disabled)
/// Color group containing `off`, `on`, `indeterminate`, `pressed` (`off`), `pressed` (`on`), `pressed`(`indeterminate`), and `disabled`.
///
/// Used for mapping `GenericState_OffOnIndeterminatePressedDisabled` to model, via `value(for:)` method.
public struct GenericStateModel_OffOnIndeterminatePressedDisabled<Value> {
    // MARK: Properties
    /// Off value.
    public var off: Value
    
    /// On value.
    public var on: Value
    
    /// Indeterminate value.
    public var indeterminate: Value
    
    /// Pressed (off) value.
    public var pressedOff: Value
    
    /// Pressed (on) value.
    public var pressedOn: Value
    
    /// Pressed (indeterminate) value.
    public var pressedIndeterminate: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_OffOnIndeterminatePressedDisabled` with values.
    public init(
        off: Value,
        on: Value,
        indeterminate: Value,
        pressedOff: Value,
        pressedOn: Value,
        pressedIndeterminate: Value,
        disabled: Value
    ) {
        self.off = off
        self.on = on
        self.indeterminate = indeterminate
        self.pressedOff = pressedOff
        self.pressedOn = pressedOn
        self.pressedIndeterminate = pressedIndeterminate
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_OffOnIndeterminatePressedDisabled` with values.
    public init(
        off: Value,
        on: Value,
        indeterminate: Value,
        pressed: Value,
        disabled: Value
    ) {
        self.off = off
        self.on = on
        self.indeterminate = indeterminate
        self.pressedOff = pressed
        self.pressedOn = pressed
        self.pressedIndeterminate = pressed
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_OffOnIndeterminatePressedDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
        self.indeterminate = value
        self.pressedOff = value
        self.pressedOn = value
        self.pressedIndeterminate = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_OffOnIndeterminatePressedDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OffOnIndeterminatePressedDisabled<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_OffOnIndeterminatePressedDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OffOnIndeterminatePressedDisabled<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_OffOnIndeterminatePressedDisabled {
    /// Initializes `GenericStateModel_OffOnIndeterminatePressedDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OffOnIndeterminatePressedDisabled<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_OffOnIndeterminatePressedDisabled {
    /// Initializes `GenericStateModel_OffOnIndeterminatePressedDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OffOnIndeterminatePressedDisabled<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Equatable, Hashable, Comparable
extension GenericStateModel_OffOnIndeterminatePressedDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_OffOnIndeterminatePressedDisabled: Hashable where Value: Hashable {}

extension GenericStateModel_OffOnIndeterminatePressedDisabled: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.off, \.on, \.indeterminate, \.pressedOff, \.pressedOn, \.pressedIndeterminate, \.disabled)
    }
}

// MARK: - Mapping
extension GenericStateModel_OffOnIndeterminatePressedDisabled {
    public func value(for state: GenericState_OffOnIndeterminatePressedDisabled) -> Value {
        switch state {
        case .off: return off
        case .on: return on
        case .indeterminate: return indeterminate
        case .pressedOff: return pressedOff
        case .pressedOn: return pressedOn
        case .pressedIndeterminate: return pressedIndeterminate
        case .disabled: return disabled
        }
    }
}
