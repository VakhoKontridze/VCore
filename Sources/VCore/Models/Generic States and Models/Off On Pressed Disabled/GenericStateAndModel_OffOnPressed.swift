//
//  GenericState_OffOnPressed.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Generic State (Off, On, Pressed)
/// Enumeration that represents state, such as `off`, `on`, `pressed` (`off`), or `pressed` (`on`).
///
/// Used for mapping state to `GenericStateModel_OffOnPressed`, via `value(for:)` method.
public enum GenericState_OffOnPressed: Int, CaseIterable {
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
    /// Initializes `GenericState_OffOnPressed` with flags.
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
/// Used for mapping `GenericState_OffOnPressed` to model, via `value(for:)` method.
public struct GenericStateModel_OffOnPressed<Value> {
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
    /// Initializes `GenericStateModel_OffOnPressed` with values.
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
    
    /// Initializes `GenericStateModel_OffOnPressed` with values.
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
    
    /// Initializes `GenericStateModel_OffOnPressed` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
        self.pressedOff = value
        self.pressedOn = value
    }
    
    /// Initializes `GenericStateModel_OffOnPressed` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OffOnPressed<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_OffOnPressed` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OffOnPressed<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializers
#if canImport(UIKit)

import UIKit

extension GenericStateModel_OffOnPressed {
    /// Initializes `GenericStateModel_OffOnPressed` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OffOnPressed<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_OffOnPressed {
    /// Initializes `GenericStateModel_OffOnPressed` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OffOnPressed<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_OffOnPressed {
    /// Initializes `GenericStateModel_OffOnPressed` with `GenericStateModel_OffOnPressedDisabled`.
    public init(_ model: GenericStateModel_OffOnPressedDisabled<Value>) {
        self.init(
            off: model.off,
            on: model.on,
            pressedOff: model.pressedOff,
            pressedOn: model.pressedOn
        )
    }
}

// MARK: Equatable, Hashable, Comparable
extension GenericStateModel_OffOnPressed: Equatable where Value: Equatable {}

extension GenericStateModel_OffOnPressed: Hashable where Value: Hashable {}

extension GenericStateModel_OffOnPressed: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.off, \.on, \.pressedOff, \.pressedOn)
    }
}

// MARK: - Mapping
extension GenericStateModel_OffOnPressed {
    /// Maps `GenericState_OffOnPressed` to `GenericStateModel_OffOnPressed`.
    public func value(for state: GenericState_OffOnPressed) -> Value {
        switch state {
        case .off: return off
        case .on: return on
        case .pressedOff: return pressedOff
        case .pressedOn: return pressedOn
        }
    }
}
