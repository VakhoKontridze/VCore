//
//  GenericState_OOID.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Generic State (Off, On, Indeterminate, Disabled)
/// Enumeration that represents state, such as `off`, `on`, `indeterminate`, or `disabled`.
///
/// Used for mapping state to `GenericStateModel_OOID`, via `value(for:)` method.
public enum GenericState_OOID: Int, CaseIterable {
    // MARK: Cases
    /// Off.
    case off
    
    /// On.
    case on
    
    /// Indeterminate.
    case indeterminate
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if interaction is enabled.
    public var isEnabled: Bool {
        switch self {
        case .off: return true
        case .on: return true
        case .indeterminate: return true
        case .disabled: return false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_OOPD` with flags.
    public init(isEnabled: Bool, state: GenericState_OOI) {
        switch (isEnabled, state) {
        case (false, _): self = .disabled
        case (true, .off): self = .off
        case (true, .on): self = .on
        case (true, .indeterminate): self = .indeterminate
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .off: self = .on
        case .on: self = .off
        case .indeterminate: self = .on
        case .disabled: break
        }
    }
}

// MARK: - Generic State Model (Off, On, Indeterminate, Disabled)
/// Color group containing `off`, `on`, `indeterminate`, and `disabled`.
///
/// Used for mapping `GenericState_OOID` to model, via `value(for:)` method.
public struct GenericStateModel_OOID<Value> {
    // MARK: Properties
    /// Off value.
    public var off: Value
    
    /// On value.
    public var on: Value
    
    /// Indeterminate value.
    public var indeterminate: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_OOID` with values.
    public init(
        off: Value,
        on: Value,
        indeterminate: Value,
        disabled: Value
    ) {
        self.off = off
        self.on = on
        self.indeterminate = indeterminate
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_OOID` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
        self.indeterminate = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_OOID` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OOID<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_OOID` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OOID<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_OOID {
    /// Initializes `GenericStateModel_OOID` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OOID<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_OOID {
    /// Initializes `GenericStateModel_OOID` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OOID<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_OOID {
    /// Initializes `GenericStateModel_OOID` with `GenericState_OOIPD`.
    public init(_ model: GenericStateModel_OOIPD<Value>) {
        self.init(
            off: model.off,
            on: model.on,
            indeterminate: model.indeterminate,
            disabled: model.disabled
        )
    }
}

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_OOID: Hashable where Value: Hashable {}

extension GenericStateModel_OOID: Equatable where Value: Equatable {}

extension GenericStateModel_OOID: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.off, \.on, \.indeterminate, \.disabled)
    }
}

// MARK: - Mapping
extension GenericStateModel_OOID {
    public func value(for state: GenericState_OOID) -> Value {
        switch state {
        case .off: return off
        case .on: return on
        case .indeterminate: return indeterminate
        case .disabled: return disabled
        }
    }
}
