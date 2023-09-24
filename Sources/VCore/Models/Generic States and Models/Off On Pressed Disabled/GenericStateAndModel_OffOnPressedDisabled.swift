//
//  GenericStateAndModel_OffOnPressedDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 3/1/22.
//

import SwiftUI

// MARK: - Generic State (Off, On, Pressed, Disabled)
/// Enumeration that represents state, such as `off`, `on`, `pressed` (`off`), `pressed` (`on`), or `disabled`.
///
/// Used for mapping state to `GenericStateModel_OffOnPressedDisabled`, via `value(for:)` method.
public enum GenericState_OffOnPressedDisabled: Int, CaseIterable {
    // MARK: Cases
    /// Off.
    case off
    
    /// On.
    case on
    
    /// Pressed (off).
    case pressedOff
    
    /// Pressed (on).
    case pressedOn
    
    /// Disabled
    case disabled
    
    // MARK: Properties
    /// Indicates if interaction is enabled.
    public var isEnabled: Bool {
        switch self {
        case .off: true
        case .on: true
        case .pressedOff: true
        case .pressedOn: true
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_OffOnPressedDisabled` with flags.
    public init(isEnabled: Bool, isOn: Bool, isPressed: Bool) {
        switch (isEnabled, isOn, isPressed) {
        case (false, _, _): self = .disabled
        case (true, false, false): self = .off
        case (true, false, true): self = .pressedOff
        case (true, true, false): self = .on
        case (true, true, true): self = .pressedOn
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .off, .pressedOff: self = .on
        case .on, .pressedOn: self = .off
        case .disabled: break
        }
    }
}

// MARK: - Generic State Model (Off, On, Pressed, Disabled)
/// Value group containing `off`, `on`, `pressed` (`off`), `pressed` (`on`), and `disabled`.
///
/// Used for mapping `GenericState_OffOnPressedDisabled` to model, via `value(for:)` method.
public struct GenericStateModel_OffOnPressedDisabled<Value> {
    // MARK: Properties
    /// Off value.
    public var off: Value
    
    /// On value.
    public var on: Value
    
    /// Pressed (off) value.
    public var pressedOff: Value
    
    /// Pressed (on) value.
    public var pressedOn: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_OffOnPressedDisabled` with values.
    public init(
        off: Value,
        on: Value,
        pressedOff: Value,
        pressedOn: Value,
        disabled: Value
    ) {
        self.off = off
        self.on = on
        self.pressedOff = pressedOff
        self.pressedOn = pressedOn
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_OffOnPressedDisabled` with values.
    public init(
        off: Value,
        on: Value,
        pressed: Value,
        disabled: Value
    ) {
        self.off = off
        self.on = on
        self.pressedOff = pressed
        self.pressedOn = pressed
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_OffOnPressedDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
        self.pressedOff = value
        self.pressedOn = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_OffOnPressedDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OffOnPressedDisabled<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_OffOnPressedDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OffOnPressedDisabled<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializers
#if canImport(UIKit)

import UIKit

extension GenericStateModel_OffOnPressedDisabled {
    /// Initializes `GenericStateModel_OffOnPressedDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OffOnPressedDisabled<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_OffOnPressedDisabled {
    /// Initializes `GenericStateModel_OffOnPressedDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OffOnPressedDisabled<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Equatable, Hashable, Comparable
extension GenericStateModel_OffOnPressedDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_OffOnPressedDisabled: Hashable where Value: Hashable {}

extension GenericStateModel_OffOnPressedDisabled: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.off, \.on, \.pressedOff, \.pressedOn, \.disabled)
    }
}

// MARK: - Mapping
extension GenericStateModel_OffOnPressedDisabled {
    /// Maps `GenericState_OffOnPressedDisabled` to `GenericStateModel_OffOnPressedDisabled`.
    public func value(for state: GenericState_OffOnPressedDisabled) -> Value {
        switch state {
        case .off: off
        case .on: on
        case .pressedOff: pressedOff
        case .pressedOn: pressedOn
        case .disabled: disabled
        }
    }
}
