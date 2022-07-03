//
//  GenericStateAndModel_CED.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/6/22.
//

import SwiftUI

// MARK: - Genetic State (Collapsed, Expanded, Disabled)
/// Enumeration that represents state, such as `collapsed`, `expanded`, or `disabled`.
///
/// Used for mapping state to `GenericStateModel_CED`, via `value(for:)` method.
public enum GenericState_CED: Int, CaseIterable {
    // MARK: Cases
    /// Collapsed.
    case collapsed
    
    /// Expanded.
    case expanded
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if interaction is enabled.
    public var isEnabled: Bool {
        switch self {
        case .collapsed: return true
        case .expanded: return true
        case .disabled: return false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_CED` with flags.
    public init(isEnabled: Bool, isExpanded: Bool) {
        switch (isEnabled, isExpanded) {
        case (false, _): self = .disabled
        case (true, false): self = .collapsed
        case (true, true): self = .expanded
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .collapsed: self = .expanded
        case .expanded: self = .collapsed
        case .disabled: break
        }
    }
}

// MARK: - Generic State Model (Collapsed, Expanded, Disabled)
/// Value group containing generic `collapsed`, `expanded`, and `disabled` values.
///
/// Used for mapping `GenericState_CED` to model, via `value(for:)` method.
public struct GenericStateModel_CED<Value> {
    // MARK: Properties
    /// Collapsed value.
    public var collapsed: Value
    
    /// Expanded value.
    public var expanded: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_CED` with values.
    public init(
        collapsed: Value,
        expanded: Value,
        disabled: Value
    ) {
        self.collapsed = collapsed
        self.expanded = expanded
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_CED` with value.
    public init(
        _ value: Value
    ) {
        self.collapsed = value
        self.expanded = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_CED` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_CED<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_CED` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_CED<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_CED {
    /// Initializes `GenericStateModel_CED` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_CED<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_CED {
    /// Initializes `GenericStateModel_CED` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_CED<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_CED: Hashable where Value: Hashable {}

extension GenericStateModel_CED: Equatable where Value: Equatable {}

extension GenericStateModel_CED: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.collapsed, \.expanded, \.disabled)
    }
}

// MARK: - Mapping
extension GenericStateModel_CED {
    /// Maps `GenericState_CED` to `GenericStateModel_CED`.
    public func value(for state: GenericState_CED) -> Value {
        switch state {
        case .collapsed: return collapsed
        case .expanded: return expanded
        case .disabled: return disabled
        }
    }
}
