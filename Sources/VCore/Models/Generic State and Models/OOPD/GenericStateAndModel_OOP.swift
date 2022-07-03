//
//  GenericState_OOP.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Generic State (Off, On, Pressed)
/// Enumeration that represents state, such as `off`, `on`, `pressed` (`off`), or `pressed` (`on`).
///
/// Used for mapping state to `GenericStateModel_OOP`, via `value(for:)` method.
public enum GenericState_OOP: Int, CaseIterable {
    // MARK: Cases
    /// Off.
    case off
    
    /// On.
    case on
    
    /// Pressed (off).
    case pressedOff
    
    /// Pressed (on).
    case pressedOn
        
    // MARK: Initializers
    /// Initializes `GenericState_OOP` with flags.
    public init(isOn: Bool, isPressed: Bool) {
        switch (isOn, isPressed) {
        case (false, false): self = .off
        case (false, true): self = .pressedOff
        case (true, false): self = .on
        case (true, true): self = .pressedOn
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .off, .pressedOff: self = .on
        case .on, .pressedOn: self = .off
        }
    }
}

// MARK: - Generic State Model (Off, On, Pressed)
/// Color group containing `off`, `on`, `pressed` (`off`), and `pressed` (`on`).
///
/// Used for mapping `GenericState_OOP` to model, via `value(for:)` method.
public struct GenericStateModel_OOP<Value> {
    // MARK: Properties
    /// Off value.
    public var off: Value
    
    /// On value.
    public var on: Value
    
    /// Pressed (off) value.
    public var pressedOff: Value
    
    /// Pressed (on) value.
    public var pressedOn: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_OOP` with values.
    public init(
        off: Value,
        on: Value,
        pressedOff: Value,
        pressedOn: Value
    ) {
        self.off = off
        self.on = on
        self.pressedOff = pressedOff
        self.pressedOn = pressedOn
    }
    
    /// Initializes `GenericStateModel_OOP` with values.
    public init(
        off: Value,
        on: Value,
        pressed: Value
    ) {
        self.off = off
        self.on = on
        self.pressedOff = pressed
        self.pressedOn = pressed
    }
    
    /// Initializes `GenericStateModel_OOP` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
        self.pressedOff = value
        self.pressedOn = value
    }
    
    /// Initializes `GenericStateModel_OOP` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OOP<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_OOP` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OOP<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_OOP {
    /// Initializes `GenericStateModel_OOP` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OOP<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_OOP {
    /// Initializes `GenericStateModel_OOP` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OOP<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_OOP: Hashable where Value: Hashable {}

extension GenericStateModel_OOP: Equatable where Value: Equatable {}

extension GenericStateModel_OOP: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.off, \.on, \.pressedOff, \.pressedOn)
    }
}

// MARK: - Mapping
extension GenericStateModel_OOP {
    /// Maps `GenericState_OOP` to `GenericStateModel_OOP`.
    public func value(for state: GenericState_OOP) -> Value {
        switch state {
        case .off: return off
        case .on: return on
        case .pressedOff: return pressedOff
        case .pressedOn: return pressedOn
        }
    }
}
