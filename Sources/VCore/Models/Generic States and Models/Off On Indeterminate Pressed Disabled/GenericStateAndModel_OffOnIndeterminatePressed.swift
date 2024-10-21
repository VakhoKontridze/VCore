//
//  GenericStateAndModel_OffOnIndeterminatePressed.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Generic State (Off, On, Indeterminate, Pressed)
/// Enumeration that represents state.
///
/// Used for mapping state to `GenericStateModel_OffOnIndeterminatePressed`, with `value(for:)` method.
public enum GenericState_OffOnIndeterminatePressed: Int, Sendable, CaseIterable {
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
/// Used for mapping `GenericState_OffOnIndeterminatePressed` to model, with `value(for:)` method.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_OffOnIndeterminatePressed` with values."
)
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
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_OffOnIndeterminatePressed` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OffOnIndeterminatePressed<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_OffOnIndeterminatePressed` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OffOnIndeterminatePressed<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_OffOnIndeterminatePressed` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OffOnIndeterminatePressed<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_OffOnIndeterminatePressed` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OffOnIndeterminatePressed<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Initializers - Model Casting
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

    // MARK: Map
    /// Returns `GenericStateModel_OffOnIndeterminatePressed`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            off: try transform(off),
            on: try transform(on),
            indeterminate: try transform(indeterminate),
            pressedOff: try transform(pressedOff),
            pressedOn: try transform(pressedOn),
            pressedIndeterminate: try transform(pressedIndeterminate)
        )
    }
}

// MARK: Equatable, Hashable
extension GenericStateModel_OffOnIndeterminatePressed: Equatable where Value: Equatable {}

extension GenericStateModel_OffOnIndeterminatePressed: Hashable where Value: Hashable {}

// MARK: Sendable
extension GenericStateModel_OffOnIndeterminatePressed: Sendable where Value: Sendable {}

// MARK: - State-Model Mapping
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
