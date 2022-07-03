//
//  GenericStateAndModel_OOPD.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 3/1/22.
//

import SwiftUI

// MARK: - Generic State (Off, On, Pressed, Disabled)
/// Enumeration that represents state, such as `off`, `on`, `pressed` (`off`), `pressed` (`on`), or `disabled`.
///
/// Used for mapping state to `GenericStateModel_OOPD`, via `value(for:)` method.
public enum GenericState_OOPD: Int, CaseIterable {
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
        case .off: return true
        case .on: return true
        case .pressedOff: return true
        case .pressedOn: return true
        case .disabled: return false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_OOPD` with flags.
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
/// Color group containing `off`, `on`, `pressed` (`off`), `pressed` (`on`), and `disabled`.
///
/// Used for mapping `GenericState_OOPD` to model, via `value(for:)` method.
public struct GenericStateModel_OOPD<Value> {
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
    /// Initializes `GenericStateModel_OOPD` with values.
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
    
    /// Initializes `GenericStateModel_OOPD` with values.
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
    
    /// Initializes `GenericStateModel_OOPD` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
        self.pressedOff = value
        self.pressedOn = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_OOPD` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OOPD<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_OOPD` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OOPD<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_OOPD {
    /// Initializes `GenericStateModel_OOPD` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OOPD<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_OOPD {
    /// Initializes `GenericStateModel_OOPD` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OOPD<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_OOPD: Hashable where Value: Hashable {}

extension GenericStateModel_OOPD: Equatable where Value: Equatable {}

extension GenericStateModel_OOPD: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.off, \.on, \.pressedOff, \.pressedOn, \.disabled)
    }
}

// MARK: - Mapping
extension GenericStateModel_OOPD {
    /// Maps `GenericState_OOPD` to `GenericStateModel_OOPD`.
    public func value(for state: GenericState_OOPD) -> Value {
        switch state {
        case .off: return off
        case .on: return on
        case .pressedOff: return pressedOff
        case .pressedOn: return pressedOn
        case .disabled: return disabled
        }
    }
}
