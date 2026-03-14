//
//  GenericStateAndModel_CollapsedExpanded.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Enumeration that represents state.
public nonisolated enum GenericState_CollapsedExpanded: Int, Sendable, CaseIterable {
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

nonisolated extension Binding where Value == GenericState_CollapsedExpanded {
    /// Initializes `GenericState_CollapsedExpanded` with `Bool`.
    public init(isExpanded: Binding<Bool>) {
        self.init(
            get: { GenericState_CollapsedExpanded(isExpanded: isExpanded.wrappedValue) },
            set: { isExpanded.wrappedValue = $0 == .expanded }
        )
    }
}

/// Model containing generic state-bound values.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_CollapsedExpanded` with values."
)
public nonisolated struct GenericStateModel_CollapsedExpanded<Value> {
    // MARK: Properties
    /// Collapsed value.
    public var collapsed: Value
    
    /// Expanded value.
    public var expanded: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_CollapsedExpanded` with value.
    public init(
        _ value: Value
    ) {
        self.collapsed = value
        self.expanded = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_CollapsedExpanded` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_CollapsedExpanded<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_CollapsedExpanded` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_CollapsedExpanded<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_CollapsedExpanded` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_CollapsedExpanded<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_CollapsedExpanded` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_CollapsedExpanded<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Initializers - Model Casting
    /// Initializes `GenericStateModel_CollapsedExpanded` with `GenericStateModel_CollapsedExpandedDisabled`.
    public init(_ model: GenericStateModel_CollapsedExpandedDisabled<Value>) {
        self.init(
            collapsed: model.collapsed,
            expanded: model.expanded
        )
    }

    // MARK: Map
    /// Returns `GenericStateModel_CollapsedExpanded`  containing the results of mapping the given closure over the values.
    public func map<NewValue>(
        _ transform: (Value) throws -> NewValue
    ) rethrows -> GenericStateModel_CollapsedExpanded<NewValue> {
        .init(
            collapsed: try transform(collapsed),
            expanded: try transform(expanded)
        )
    }
}

nonisolated extension GenericStateModel_CollapsedExpanded: Equatable where Value: Equatable {}

nonisolated extension GenericStateModel_CollapsedExpanded: Hashable where Value: Hashable {}

nonisolated extension GenericStateModel_CollapsedExpanded: Sendable where Value: Sendable {}

nonisolated extension GenericStateModel_CollapsedExpanded {
    /// Maps state to model.
    public func value(for state: GenericState_CollapsedExpanded) -> Value {
        switch state {
        case .collapsed: collapsed
        case .expanded: expanded
        }
    }
}
