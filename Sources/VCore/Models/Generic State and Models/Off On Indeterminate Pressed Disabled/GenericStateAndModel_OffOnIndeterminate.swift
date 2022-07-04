//
//  GenericStateAndModel_OffOnIndeterminate.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Generic State (Off, On, Indeterminate)
/// Enumeration that represents state, such as `off`, `on`, or `indeterminate`.
///
/// Used for mapping state to `GenericStateModel_OffOnIndeterminate`, via `value(for:)` method.
public enum GenericState_OffOnIndeterminate: Int, CaseIterable {
    // MARK: Cases
    /// Off.
    case off
    
    /// On.
    case on
    
    /// Indeterminate.
    case indeterminate
    
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

// MARK: - Generic State Model (Off, On, Indeterminate)
/// Color group containing `off`, `on`, and `indeterminate`.
///
/// Used for mapping `GenericState_OffOnIndeterminate` to model, via `value(for:)` method.
public struct GenericStateModel_OffOnIndeterminate<Value> {
    // MARK: Properties
    /// Off value.
    public var off: Value
    
    /// On value.
    public var on: Value
    
    /// Indeterminate value.
    public var indeterminate: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_OffOnIndeterminate` with values.
    public init(
        off: Value,
        on: Value,
        indeterminate: Value
    ) {
        self.off = off
        self.on = on
        self.indeterminate = indeterminate
    }
    
    /// Initializes `GenericStateModel_OffOnIndeterminate` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
        self.indeterminate = value
    }
    
    /// Initializes `GenericStateModel_OffOnIndeterminate` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OffOnIndeterminate<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_OffOnIndeterminate` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OffOnIndeterminate<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_OffOnIndeterminate {
    /// Initializes `GenericStateModel_OffOnIndeterminate` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OffOnIndeterminate<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_OffOnIndeterminate {
    /// Initializes `GenericStateModel_OffOnIndeterminate` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OffOnIndeterminate<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_OffOnIndeterminate: Hashable where Value: Hashable {}

extension GenericStateModel_OffOnIndeterminate: Equatable where Value: Equatable {}

extension GenericStateModel_OffOnIndeterminate: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.off, \.on, \.indeterminate)
    }
}

// MARK: - Mapping
extension GenericStateModel_OffOnIndeterminate {
    public func value(for state: GenericState_OffOnIndeterminate) -> Value {
        switch state {
        case .off: return off
        case .on: return on
        case .indeterminate: return indeterminate
        }
    }
}
