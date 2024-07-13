//
//  GenericStateAndModel_CollapsedExpandedDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/6/22.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Genetic State (Collapsed, Expanded, Disabled)
/// Enumeration that represents state.
///
/// Used for mapping state to `GenericStateModel_CollapsedExpandedDisabled`, with `value(for:)` method.
public enum GenericState_CollapsedExpandedDisabled: Int, CaseIterable {
    // MARK: Cases
    /// Collapsed.
    case collapsed
    
    /// Expanded.
    case expanded
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if gesture is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .collapsed: true
        case .expanded: true
        case .disabled: false
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
/// Used for mapping `GenericState_CollapsedExpandedDisabled` to model, with `value(for:)` method.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_CollapsedExpandedDisabled` with values."
)
public struct GenericStateModel_CollapsedExpandedDisabled<Value> {
    // MARK: Properties
    /// Collapsed value.
    public var collapsed: Value
    
    /// Expanded value.
    public var expanded: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_CollapsedExpandedDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.collapsed = value
        self.expanded = value
        self.disabled = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_CollapsedExpandedDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_CollapsedExpandedDisabled<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_CollapsedExpandedDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_CollapsedExpandedDisabled<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_CollapsedExpandedDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_CollapsedExpandedDisabled<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_CollapsedExpandedDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_CollapsedExpandedDisabled<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Map
    /// Returns `GenericStateModel_CollapsedExpandedDisabled`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            collapsed: try transform(collapsed),
            expanded: try transform(expanded),
            disabled: try transform(disabled)
        )
    }
}

// MARK: Equatable, Hashable
extension GenericStateModel_CollapsedExpandedDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_CollapsedExpandedDisabled: Hashable where Value: Hashable {}

// MARK: - State-Model Mapping
extension GenericStateModel_CollapsedExpandedDisabled {
    /// Maps `GenericState_CollapsedExpandedDisabled` to `GenericStateModel_CollapsedExpandedDisabled`.
    public func value(for state: GenericState_CollapsedExpandedDisabled) -> Value {
        switch state {
        case .collapsed: collapsed
        case .expanded: expanded
        case .disabled: disabled
        }
    }
}
