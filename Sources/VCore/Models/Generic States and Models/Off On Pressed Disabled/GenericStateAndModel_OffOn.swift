//
//  GenericStateAndModel_OffOn.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Generic State (Off, On, Disabled)
/// Enumeration that represents state, such as `off` or `on`.
///
/// Used for mapping state to `GenericStateModel_OffOn`, via `value(for:)` method.
public enum GenericState_OffOn: Int, CaseIterable {
    // MARK: Cases
    /// Off.
    case off
    
    /// On.
    case on
    
    // MARK: Initializers
    /// Initializes `GenericState_OffOn` with flags.
    public init(isOn: Bool) {
        switch isOn {
        case false: self = .off
        case true: self = .on
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .off: self = .on
        case .on: self = .off
        }
    }
}

// MARK: Binding Init
extension Binding where Value == GenericState_OffOn {
    /// Initializes `GenericState_OffOn` with `Bool`.
    public init(isOn: Binding<Bool>) {
        self.init(
            get: { GenericState_OffOn(isOn: isOn.wrappedValue) },
            set: { isOn.wrappedValue = $0 == .on }
        )
    }
}

// MARK: - Generic State Model (Off, On)
/// Color group containing `off` and `on`.
///
/// Used for mapping `GenericState_OffOn` to model, via `value(for:)` method.
public struct GenericStateModel_OffOn<Value> {
    // MARK: Properties
    /// Off value.
    public var off: Value
    
    /// On value.
    public var on: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_OffOn` with values.
    public init(
        off: Value,
        on: Value
    ) {
        self.off = off
        self.on = on
    }
    
    /// Initializes `GenericStateModel_OffOn` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
    }
    
    /// Initializes `GenericStateModel_OffOn` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OffOn<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_OffOn` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OffOn<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_OffOn {
    /// Initializes `GenericStateModel_OffOn` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OffOn<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_OffOn {
    /// Initializes `GenericStateModel_OffOn` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OffOn<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_OffOn {
    /// Initializes `GenericStateModel_OffOn` with `GenericStateModel_OffOnDisabled`.
    public init(_ model: GenericStateModel_OffOnDisabled<Value>) {
        self.init(
            off: model.off,
            on: model.on
        )
    }
    
    /// Initializes `GenericStateModel_OffOn` with `GenericStateModel_OffOnPressed`.
    public init(_ model: GenericStateModel_OffOnPressed<Value>) {
        self.init(
            off: model.off,
            on: model.on
        )
    }
    
    /// Initializes `GenericStateModel_OffOn` with `GenericStateModel_OffOnPressedDisabled`.
    public init(_ model: GenericStateModel_OffOnPressedDisabled<Value>) {
        self.init(
            off: model.off,
            on: model.on
        )
    }
}

// MARK: Equatable, Hashable, Comparable
extension GenericStateModel_OffOn: Equatable where Value: Equatable {}

extension GenericStateModel_OffOn: Hashable where Value: Hashable {}

extension GenericStateModel_OffOn: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.off, \.on)
    }
}

// MARK: - Mapping
extension GenericStateModel_OffOn {
    /// Maps `GenericState_OffOn` to `GenericStateModel_OffOn`.
    public func value(for state: GenericState_OffOn) -> Value {
        switch state {
        case .off: return off
        case .on: return on
        }
    }
}
