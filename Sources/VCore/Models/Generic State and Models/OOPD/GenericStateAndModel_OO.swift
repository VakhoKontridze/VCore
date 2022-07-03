//
//  GenericStateAndModel_OO.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Generic State (Off, On, Disabled)
/// Enumeration that represents state, such as `off` or `on`.
public enum GenericState_OO: Int, CaseIterable {
    // MARK: Cases
    /// Off.
    case off
    
    /// On.
    case on
    
    // MARK: Initializers
    /// Initializes `GenericState_OO` with flags.
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
extension Binding where Value == GenericState_OO {
    /// Initializes `GenericState_OO` with `Bool`.
    public init(isExpanded: Binding<Bool>) {
        self.init(
            get: { .init(isOn: isExpanded.wrappedValue) },
            set: { isExpanded.wrappedValue = $0 == .on }
        )
    }
}

// MARK: - Generic State Model (Off, On)
/// Color group containing `off` and `on`.
public struct GenericStateModel_OO<Value> {
    // MARK: Properties
    /// Off value.
    public var off: Value
    
    /// On value.
    public var on: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_OO` with values.
    public init(
        off: Value,
        on: Value
    ) {
        self.off = off
        self.on = on
    }
    
    /// Initializes `GenericStateModel_OO` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
    }
    
    /// Initializes `GenericStateModel_OO` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OO<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_OO` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OO<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_OO {
    /// Initializes `GenericStateModel_OO` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OO<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_OO {
    /// Initializes `GenericStateModel_OO` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OO<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_OO {
    /// Initializes `GenericStateModel_OO` with `GenericStateModel_OOD`.
    public init(_ model: GenericStateModel_OOD<Value>) {
        self.init(
            off: model.off,
            on: model.on
        )
    }
    
    /// Initializes `GenericStateModel_OO` with `GenericStateModel_OOP`.
    public init(_ model: GenericStateModel_OOP<Value>) {
        self.init(
            off: model.off,
            on: model.on
        )
    }
    
    /// Initializes `GenericStateModel_OO` with `GenericStateModel_OOPD`.
    public init(_ model: GenericStateModel_OOPD<Value>) {
        self.init(
            off: model.off,
            on: model.on
        )
    }
}

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_OO: Hashable where Value: Hashable {}

extension GenericStateModel_OO: Equatable where Value: Equatable {}

extension GenericStateModel_OO: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.off, \.on)
    }
}

// MARK: - Mapping
extension GenericStateModel_OO {
    /// Maps `GenericState_OO` to `GenericStateModel_OO`.
    public func value(for state: GenericState_OO) -> Value {
        switch state {
        case .off: return off
        case .on: return on
        }
    }
}
