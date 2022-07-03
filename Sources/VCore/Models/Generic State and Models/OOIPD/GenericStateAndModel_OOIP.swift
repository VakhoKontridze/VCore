//
//  GenericStateAndModel_OOIP.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Generic State (Off, On, Indeterminate, Pressed)
/// Enumeration that represents state, such as `off`, `on`, `indeterminate`, `pressed` (`off`), `pressed` (`on`)` and `pressed` (`indeterminate`).
///
/// Used for mapping state to `GenericStateModel_OOIP`, via `value(for:)` method.
public enum GenericState_OOIP: Int, CaseIterable {
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
    
    // MARK: Initializers
    /// Initializes `GenericState_OOPD` with flags.
    public init(state: GenericState_OOI, isPressed: Bool) {
        switch (state, isPressed) {
        case (.off, false): self = .off
        case (.off, true): self = .pressedOff
        case (.on, false): self = .on
        case (.on, true): self = .pressedOn
        case (.indeterminate, false): self = .indeterminate
        case (.indeterminate, true): self = .pressedIndeterminate
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .off, .pressedOff: self = .on
        case .on, .pressedOn: self = .off
        case .indeterminate, .pressedIndeterminate: self = .on
        }
    }
}

// MARK: - Generic State Model (Off, On, Indeterminate, Pressed)
/// Color group containing `off`, `on`, `indeterminate`, `pressed` (`off`), `pressed` (`on`), and `pressed`(`indeterminate`).
///
/// Used for mapping `GenericState_OOIP` to model, via `value(for:)` method.
public struct GenericStateModel_OOIP<Value> {
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
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_OOIP` with values.
    public init(
        off: Value,
        on: Value,
        indeterminate: Value,
        pressedOff: Value,
        pressedOn: Value,
        pressedIndeterminate: Value
    ) {
        self.off = off
        self.on = on
        self.indeterminate = indeterminate
        self.pressedOff = pressedOff
        self.pressedOn = pressedOn
        self.pressedIndeterminate = pressedIndeterminate
    }
    
    /// Initializes `GenericStateModel_OOIP` with values.
    public init(
        off: Value,
        on: Value,
        indeterminate: Value,
        pressed: Value
    ) {
        self.off = off
        self.on = on
        self.indeterminate = indeterminate
        self.pressedOff = pressed
        self.pressedOn = pressed
        self.pressedIndeterminate = pressed
    }
    
    /// Initializes `GenericStateModel_OOIP` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
        self.indeterminate = value
        self.pressedOff = value
        self.pressedOn = value
        self.pressedIndeterminate = value
    }
    
    /// Initializes `GenericStateModel_OOIP` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OOIP<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_OOIP` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OOIP<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_OOIP {
    /// Initializes `GenericStateModel_OOIP` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OOIP<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_OOIP {
    /// Initializes `GenericStateModel_OOIP` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OOIP<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_OOIP: Hashable where Value: Hashable {}

extension GenericStateModel_OOIP: Equatable where Value: Equatable {}

extension GenericStateModel_OOIP: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.off, \.on, \.indeterminate, \.pressedOff, \.pressedOn, \.pressedIndeterminate)
    }
}

// MARK: - Mapping
extension GenericStateModel_OOIP {
    public func value(for state: GenericState_OOIP) -> Value {
        switch state {
        case .off: return off
        case .on: return on
        case .indeterminate: return indeterminate
        case .pressedOff: return pressedOff
        case .pressedOn: return pressedOn
        case .pressedIndeterminate: return pressedIndeterminate
        }
    }
}