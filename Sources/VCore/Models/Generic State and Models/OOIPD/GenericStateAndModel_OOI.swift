//
//  GenericStateAndModel_OOI.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Generic State (Off, On, Indeterminate)
/// Enumeration that represents state, such as `off`, `on`, or `indeterminate`.
public enum GenericState_OOI: Int, CaseIterable {
    // MARK: Cases
    /// Off.
    case off
    
    /// On.
    case on
    
    /// Indeterminate.
    case indeterminate
    
    // MARK: Initializers
    /// Initializes `GenericState_OOI` with flags.
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
        case .indeterminate: self = .on
        }
    }
}

// MARK: Binding Init
extension Binding where Value == GenericState_OOI {
    /// Initializes `GenericState_OOI` with `Bool`.
    public init(isOn: Binding<Bool>) {
        self.init(
            get: { .init(isOn: isOn.wrappedValue) },
            set: { isOn.wrappedValue = $0 == .on }
        )
    }
}

// MARK: - Generic State Model (Off, On, Indeterminate)
/// Color group containing `off`, `on`, and `indeterminate`.
public struct GenericStateModel_OOI<Value> {
    // MARK: Properties
    /// Off value.
    public var off: Value
    
    /// On value.
    public var on: Value
    
    /// Indeterminate value.
    public var indeterminate: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_OOI` with values.
    public init(
        off: Value,
        on: Value,
        indeterminate: Value
    ) {
        self.off = off
        self.on = on
        self.indeterminate = indeterminate
    }
    
    /// Initializes `GenericStateModel_OOI` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
        self.indeterminate = value
    }
    
    /// Initializes `GenericStateModel_OOI` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OOI<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_OOI` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OOI<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_OOI {
    /// Initializes `GenericStateModel_OOI` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OOI<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_OOI {
    /// Initializes `GenericStateModel_OOI` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OOI<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_OOI {
    /// Initializes `GenericStateModel_OOI` with `GenericStateModel_OOID`.
    public init(_ model: GenericStateModel_OOID<Value>) {
        self.init(
            off: model.off,
            on: model.on,
            indeterminate: model.indeterminate
        )
    }
    
    /// Initializes `GenericStateModel_OOI` with `GenericStateModel_OOIP`.
    public init(_ model: GenericStateModel_OOIP<Value>) {
        self.init(
            off: model.off,
            on: model.on,
            indeterminate: model.indeterminate
        )
    }
    
    /// Initializes `GenericStateModel_OOI` with `GenericStateModel_OOIPD`.
    public init(_ model: GenericStateModel_OOIPD<Value>) {
        self.init(
            off: model.off,
            on: model.on,
            indeterminate: model.indeterminate
        )
    }
}

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_OOI: Hashable where Value: Hashable {}

extension GenericStateModel_OOI: Equatable where Value: Equatable {}

extension GenericStateModel_OOI: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.off, \.on, \.indeterminate)
    }
}

// MARK: - Mapping
extension GenericStateModel_OOI {
    public func value(for state: GenericState_OOI) -> Value {
        switch state {
        case .off: return off
        case .on: return on
        case .indeterminate: return indeterminate
        }
    }
}
