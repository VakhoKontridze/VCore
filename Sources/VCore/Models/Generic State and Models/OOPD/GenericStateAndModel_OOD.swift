//
//  GenericState_OOD.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Generic State (Off, On, Disabled)
/// Enumeration that represents state, such as `off`, `on`, or `disabled`.
///
/// Used for mapping state to `GenericStateModel_OOD`, via `value(for:)` method.
public enum GenericState_OOD: Int, CaseIterable {
    // MARK: Cases
    /// Off.
    case off
    
    /// On.
    case on
    
    /// Disabled
    case disabled
    
    // MARK: Properties
    /// Indicates if interaction is enabled.
    public var isEnabled: Bool {
        switch self {
        case .off: return true
        case .on: return true
        case .disabled: return false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_OOD` with flags.
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
/// Color group containing `off`, `on`, and `disabled`.
///
/// Used for mapping `GenericState_OOD` to model, via `value(for:)` method.
public struct GenericStateModel_OOD<Value> {
    // MARK: Properties
    /// Off value.
    public var off: Value
    
    /// On value.
    public var on: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_OOD` with values.
    public init(
        off: Value,
        on: Value,
        disabled: Value
    ) {
        self.off = off
        self.on = on
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_OOD` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_OOD` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OOD<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_OOD` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OOD<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_OOD {
    /// Initializes `GenericStateModel_OOD` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OOD<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_OOD {
    /// Initializes `GenericStateModel_OOD` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OOD<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_OOD {
    /// Initializes `GenericStateModel_OOD` with `GenericStateModel_OOPD`.
    public init(_ model: GenericStateModel_OOPD<Value>) {
        self.init(
            off: model.off,
            on: model.on,
            disabled: model.disabled
        )
    }
}

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_OOD: Hashable where Value: Hashable {}

extension GenericStateModel_OOD: Equatable where Value: Equatable {}

extension GenericStateModel_OOD: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.off, \.on, \.disabled)
    }
}

// MARK: - Mapping
extension GenericStateModel_OOD {
    /// Maps `GenericState_OOD` to `GenericStateModel_OOD`.
    public func value(for state: GenericState_OOD) -> Value {
        switch state {
        case .off: return off
        case .on: return on
        case .disabled: return disabled
        }
    }
}
