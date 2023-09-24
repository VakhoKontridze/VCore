//
//  GenericStateAndModel_OffOnIndeterminatePressed.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Generic State (Off, On, Indeterminate, Pressed)
/// Enumeration that represents state, such as `off`, `on`, `indeterminate`, `pressed` (`off`), `pressed` (`on`)` and `pressed` (`indeterminate`).
///
/// Used for mapping state to `GenericStateModel_OffOnIndeterminatePressed`, via `value(for:)` method.
public enum GenericState_OffOnIndeterminatePressed: Int, CaseIterable {
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
    /// Initializes `GenericState_OffOnPressedDisabled` with flags.
    public init(state: GenericState_OffOnIndeterminate, isPressed: Bool) {
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
/// Value group containing `off`, `on`, `indeterminate`, `pressed` (`off`), `pressed` (`on`), and `pressed`(`indeterminate`).
///
/// Used for mapping `GenericState_OffOnIndeterminatePressed` to model, via `value(for:)` method.
public struct GenericStateModel_OffOnIndeterminatePressed<Value> {
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
    /// Initializes `GenericStateModel_OffOnIndeterminatePressed` with values.
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
    
    /// Initializes `GenericStateModel_OffOnIndeterminatePressed` with values.
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
    
    /// Initializes `GenericStateModel_OffOnIndeterminatePressed` with value.
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
    
    /// Initializes `GenericStateModel_OffOnIndeterminatePressed` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OffOnIndeterminatePressed<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_OffOnIndeterminatePressed` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OffOnIndeterminatePressed<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializers
#if canImport(UIKit)

import UIKit

extension GenericStateModel_OffOnIndeterminatePressed {
    /// Initializes `GenericStateModel_OffOnIndeterminatePressed` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OffOnIndeterminatePressed<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_OffOnIndeterminatePressed {
    /// Initializes `GenericStateModel_OffOnIndeterminatePressed` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OffOnIndeterminatePressed<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_OffOnIndeterminatePressed {
    /// Initializes `GenericStateModel_OffOnIndeterminatePressed` with `GenericStateModel_OffOnIndeterminatePressedDisabled`.
    public init(_ model: GenericStateModel_OffOnIndeterminatePressedDisabled<Value>) {
        self.init(
            off: model.off,
            on: model.on,
            indeterminate: model.indeterminate,
            pressedOff: model.pressedOff,
            pressedOn: model.pressedOn,
            pressedIndeterminate: model.pressedIndeterminate
        )
    }
}

// MARK: Equatable, Hashable, Comparable
extension GenericStateModel_OffOnIndeterminatePressed: Equatable where Value: Equatable {}

extension GenericStateModel_OffOnIndeterminatePressed: Hashable where Value: Hashable {}

extension GenericStateModel_OffOnIndeterminatePressed: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.off, \.on, \.indeterminate, \.pressedOff, \.pressedOn, \.pressedIndeterminate)
    }
}

// MARK: - Mapping
extension GenericStateModel_OffOnIndeterminatePressed {
    public func value(for state: GenericState_OffOnIndeterminatePressed) -> Value {
        switch state {
        case .off: off
        case .on: on
        case .indeterminate: indeterminate
        case .pressedOff: pressedOff
        case .pressedOn: pressedOn
        case .pressedIndeterminate: pressedIndeterminate
        }
    }
}
