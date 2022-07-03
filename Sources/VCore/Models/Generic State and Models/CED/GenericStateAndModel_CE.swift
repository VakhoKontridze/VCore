//
//  GenericStateAndModel_CE.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Genetic State (Collapsed, Expanded)
/// Enumeration that represents state, such as `collapsed` or `expanded`.
public enum GenericState_CE: Int, CaseIterable {
    // MARK: Cases
    /// Collapsed.
    case collapsed
    
    /// Expanded.
    case expanded
    
    // MARK: Initializers
    /// Initializes `GenericState_CE` with flags.
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
extension Binding where Value == GenericState_CE {
    /// Initializes `GenericState_CE` with `Bool`.
    public init(_ isExpanded: Binding<Bool>) {
        self.init(
            get: { .init(isExpanded: isExpanded.wrappedValue) },
            set: { isExpanded.wrappedValue = $0 == .expanded }
        )
    }
}

// MARK: - Generic State Model (Collapsed, Expanded)
/// Value group containing generic `collapsed` and `expanded` values.
///
/// Used for mapping `GenericState_CE` to model.
public struct GenericStateModel_CE<Value> {
    // MARK: Properties
    /// Collapsed value.
    public var collapsed: Value
    
    /// Expanded value.
    public var expanded: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_CE` with values.
    public init(
        collapsed: Value,
        expanded: Value
    ) {
        self.collapsed = collapsed
        self.expanded = expanded
    }
    
    /// Initializes `GenericStateModel_CE` with value.
    public init(
        _ value: Value
    ) {
        self.collapsed = value
        self.expanded = value
    }
    
    /// Initializes `GenericStateModel_CE` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_CE<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_CE` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_CE<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_CE {
    /// Initializes `GenericStateModel_CE` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_CE<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_CE {
    /// Initializes `GenericStateModel_CE` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_CE<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_CE: Hashable where Value: Hashable {}

extension GenericStateModel_CE: Equatable where Value: Equatable {}

extension GenericStateModel_CE: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.collapsed, \.expanded)
    }
}

// MARK: - Mapping
extension GenericStateModel_CE {
    /// Maps `GenericState_CE` to `GenericStateModel_CE`.
    public func value(for state: GenericState_CE) -> Value {
        switch state {
        case .collapsed: return collapsed
        case .expanded: return expanded
        }
    }
}
