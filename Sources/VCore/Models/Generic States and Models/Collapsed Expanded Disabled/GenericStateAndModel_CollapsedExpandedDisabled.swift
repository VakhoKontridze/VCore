//
//  GenericStateAndModel_CollapsedExpandedDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/6/22.
//

import SwiftUI

// MARK: - Genetic State (Collapsed, Expanded, Disabled)
/// Enumeration that represents state, such as `collapsed`, `expanded`, or `disabled`.
///
/// Used for mapping state to `GenericStateModel_CollapsedExpandedDisabled`, via `value(for:)` method.
public enum GenericState_CollapsedExpandedDisabled: Int, CaseIterable {
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
    /// Initializes `GenericState_CollapsedExpandedDisabled` with flags.
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
/// Used for mapping `GenericState_CollapsedExpandedDisabled` to model, via `value(for:)` method.
public struct GenericStateModel_CollapsedExpandedDisabled<Value> {
    // MARK: Properties
    /// Collapsed value.
    public var collapsed: Value
    
    /// Expanded value.
    public var expanded: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_CollapsedExpandedDisabled` with values.
    public init(
        collapsed: Value,
        expanded: Value,
        disabled: Value
    ) {
        self.collapsed = collapsed
        self.expanded = expanded
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_CollapsedExpandedDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.collapsed = value
        self.expanded = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_CollapsedExpandedDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_CollapsedExpandedDisabled<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_CollapsedExpandedDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_CollapsedExpandedDisabled<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_CollapsedExpandedDisabled {
    /// Initializes `GenericStateModel_CollapsedExpandedDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_CollapsedExpandedDisabled<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_CollapsedExpandedDisabled {
    /// Initializes `GenericStateModel_CollapsedExpandedDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_CollapsedExpandedDisabled<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_CollapsedExpandedDisabled: Hashable where Value: Hashable {}

extension GenericStateModel_CollapsedExpandedDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_CollapsedExpandedDisabled: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.collapsed, \.expanded, \.disabled)
    }
}

// MARK: - Mapping
extension GenericStateModel_CollapsedExpandedDisabled {
    /// Maps `GenericState_CollapsedExpandedDisabled` to `GenericStateModel_CollapsedExpandedDisabled`.
    public func value(for state: GenericState_CollapsedExpandedDisabled) -> Value {
        switch state {
        case .collapsed: return collapsed
        case .expanded: return expanded
        case .disabled: return disabled
        }
    }
}
