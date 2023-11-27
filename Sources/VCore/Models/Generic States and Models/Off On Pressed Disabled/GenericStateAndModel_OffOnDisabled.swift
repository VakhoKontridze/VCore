//
//  GenericState_OffOnDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Generic State (Off, On, Disabled)
/// Enumeration that represents state, such as `off`, `on`, or `disabled`.
///
/// Used for mapping state to `GenericStateModel_OffOnDisabled`, via `value(for:)` method.
public enum GenericState_OffOnDisabled: Int, CaseIterable {
    // MARK: Cases
    /// Off.
    case off
    
    /// On.
    case on
    
    /// Disabled
    case disabled
    
    // MARK: Properties
    /// Indicates if gesture is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .off: true
        case .on: true
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_OffOnDisabled` with flags.
    public init(isEnabled: Bool, isOn: Bool) {
        switch (isEnabled, isOn) {
        case (false, _): self = .disabled
        case (true, false): self = .off
        case (true, true): self = .on
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .off: self = .on
        case .on: self = .off
        case .disabled: break
        }
    }
}

// MARK: - Generic State Model (Off, On, Disabled)
/// Value group containing `off`, `on`, and `disabled`.
///
/// Used for mapping `GenericState_OffOnDisabled` to model, via `value(for:)` method.
public struct GenericStateModel_OffOnDisabled<Value> {
    // MARK: Properties
    /// Off value.
    public var off: Value
    
    /// On value.
    public var on: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_OffOnDisabled` with values.
    public init(
        off: Value,
        on: Value,
        disabled: Value
    ) {
        self.off = off
        self.on = on
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_OffOnDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_OffOnDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OffOnDisabled<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_OffOnDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OffOnDisabled<Color> {
        .init(.clear)
    }

    // MARK: Map
    /// Returns `GenericStateModel_OffOnDisabled`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            off: try transform(off),
            on: try transform(on),
            disabled: try transform(disabled)
        )
    }
}

// MARK: Platform-Specific Initializers
#if canImport(UIKit)

import UIKit

extension GenericStateModel_OffOnDisabled {
    /// Initializes `GenericStateModel_OffOnDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OffOnDisabled<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_OffOnDisabled {
    /// Initializes `GenericStateModel_OffOnDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OffOnDisabled<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_OffOnDisabled {
    /// Initializes `GenericStateModel_OffOnDisabled` with `GenericStateModel_OffOnPressedDisabled`.
    public init(_ model: GenericStateModel_OffOnPressedDisabled<Value>) {
        self.init(
            off: model.off,
            on: model.on,
            disabled: model.disabled
        )
    }
}

// MARK: Equatable, Hashable, Comparable
extension GenericStateModel_OffOnDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_OffOnDisabled: Hashable where Value: Hashable {}

extension GenericStateModel_OffOnDisabled: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.off, \.on, \.disabled)
    }
}

// MARK: - State-Model Mapping
extension GenericStateModel_OffOnDisabled {
    /// Maps `GenericState_OffOnDisabled` to `GenericStateModel_OffOnDisabled`.
    public func value(for state: GenericState_OffOnDisabled) -> Value {
        switch state {
        case .off: off
        case .on: on
        case .disabled: disabled
        }
    }
}
