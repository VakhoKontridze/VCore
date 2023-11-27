//
//  GenericStateAndModel_CollapsedExpanded.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Genetic State (Collapsed, Expanded)
/// Enumeration that represents state, such as `collapsed` or `expanded`.
///
/// Used for mapping state to `GenericStateModel_CollapsedExpanded`, via `value(for:)` method.
public enum GenericState_CollapsedExpanded: Int, CaseIterable {
    // MARK: Cases
    /// Collapsed.
    case collapsed
    
    /// Expanded.
    case expanded
    
    // MARK: Initializers
    /// Initializes `GenericState_CollapsedExpanded` with flags.
    public init(isExpanded: Bool) {
        switch isExpanded {
        case false: self = .collapsed
        case true: self = .expanded
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .collapsed: self = .expanded
        case .expanded: self = .collapsed
        }
    }
}

// MARK: Binding Init
extension Binding where Value == GenericState_CollapsedExpanded {
    /// Initializes `GenericState_CollapsedExpanded` with `Bool`.
    public init(isExpanded: Binding<Bool>) {
        self.init(
            get: { GenericState_CollapsedExpanded(isExpanded: isExpanded.wrappedValue) },
            set: { isExpanded.wrappedValue = $0 == .expanded }
        )
    }
}

// MARK: - Generic State Model (Collapsed, Expanded)
/// Value group containing generic `collapsed` and `expanded` values.
///
/// Used for mapping `GenericState_CollapsedExpanded` to model, via `value(for:)` method.
public struct GenericStateModel_CollapsedExpanded<Value> {
    // MARK: Properties
    /// Collapsed value.
    public var collapsed: Value
    
    /// Expanded value.
    public var expanded: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_CollapsedExpanded` with values.
    public init(
        collapsed: Value,
        expanded: Value
    ) {
        self.collapsed = collapsed
        self.expanded = expanded
    }
    
    /// Initializes `GenericStateModel_CollapsedExpanded` with value.
    public init(
        _ value: Value
    ) {
        self.collapsed = value
        self.expanded = value
    }
    
    /// Initializes `GenericStateModel_CollapsedExpanded` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_CollapsedExpanded<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_CollapsedExpanded` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_CollapsedExpanded<Color> {
        .init(.clear)
    }

    // MARK: Map
    /// Returns `GenericStateModel_CollapsedExpanded`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            collapsed: try transform(collapsed),
            expanded: try transform(expanded)
        )
    }
}

// MARK: Platform-Specific Initializers
#if canImport(UIKit)

import UIKit

extension GenericStateModel_CollapsedExpanded {
    /// Initializes `GenericStateModel_CollapsedExpanded` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_CollapsedExpanded<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_CollapsedExpanded {
    /// Initializes `GenericStateModel_CollapsedExpanded` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_CollapsedExpanded<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_CollapsedExpanded {
    /// Initializes `GenericStateModel_CollapsedExpanded` with `GenericStateModel_CollapsedExpandedDisabled`.
    public init(_ model: GenericStateModel_CollapsedExpandedDisabled<Value>) {
        self.init(
            collapsed: model.collapsed,
            expanded: model.expanded
        )
    }
}

// MARK: Equatable, Hashable, Comparable
extension GenericStateModel_CollapsedExpanded: Equatable where Value: Equatable {}

extension GenericStateModel_CollapsedExpanded: Hashable where Value: Hashable {}

extension GenericStateModel_CollapsedExpanded: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.collapsed, \.expanded)
    }
}

// MARK: - State-Model Mapping
extension GenericStateModel_CollapsedExpanded {
    /// Maps `GenericState_CollapsedExpanded` to `GenericStateModel_CollapsedExpanded`.
    public func value(for state: GenericState_CollapsedExpanded) -> Value {
        switch state {
        case .collapsed: collapsed
        case .expanded: expanded
        }
    }
}
