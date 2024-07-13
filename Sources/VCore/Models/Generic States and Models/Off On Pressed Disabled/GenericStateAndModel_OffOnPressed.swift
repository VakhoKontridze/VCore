//
//  GenericState_OffOnPressed.swift
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

// MARK: - Generic State (Off, On, Pressed)
/// Enumeration that represents state.
///
/// Used for mapping state to `GenericStateModel_OffOnPressed`, with `value(for:)` method.
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
/// Value group containing `off`, `on`, `pressed` (`off`), and `pressed` (`on`).
///
/// Used for mapping `GenericState_OffOnPressed` to model, with `value(for:)` method.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_OffOnPressed` with values."
)
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
    /// Initializes `GenericStateModel_OffOnPressed` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
        self.pressedOff = value
        self.pressedOn = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_OffOnPressed` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OffOnPressed<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_OffOnPressed` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OffOnPressed<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_OffOnPressed` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OffOnPressed<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_OffOnPressed` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OffOnPressed<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Initializers - Model Casting
    /// Initializes `GenericStateModel_OffOnPressed` with `GenericStateModel_OffOnPressedDisabled`.
    public init(_ model: GenericStateModel_OffOnPressedDisabled<Value>) {
        self.init(
            off: model.off,
            on: model.on,
            pressedOff: model.pressedOff,
            pressedOn: model.pressedOn
        )
    }

    // MARK: Map
    /// Returns `GenericState_OffOnPressed`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            off: try transform(off),
            on: try transform(on),
            pressedOff: try transform(pressedOff),
            pressedOn: try transform(pressedOn)
        )
    }
}

// MARK: Equatable, Hashable
extension GenericStateModel_OffOnPressed: Equatable where Value: Equatable {}

extension GenericStateModel_OffOnPressed: Hashable where Value: Hashable {}

// MARK: - State-Model Mapping
extension GenericStateModel_OffOnPressed {
    /// Maps `GenericState_OffOnPressed` to `GenericStateModel_OffOnPressed`.
    public func value(for state: GenericState_OffOnPressed) -> Value {
        switch state {
        case .off: off
        case .on: on
        case .pressedOff: pressedOff
        case .pressedOn: pressedOn
        }
    }
}
