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

/// Enumeration that represents state.
public enum GenericState_CollapsedExpandedDisabled: Int, Sendable, CaseIterable {
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

/// Model containing generic state-bound values.
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
    public func map<NewValue>(
        _ transform: (Value) throws -> NewValue
    ) rethrows -> GenericStateModel_CollapsedExpandedDisabled<NewValue> {
        .init(
            collapsed: try transform(collapsed),
            expanded: try transform(expanded),
            disabled: try transform(disabled)
        )
    }
}

extension GenericStateModel_CollapsedExpandedDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_CollapsedExpandedDisabled: Hashable where Value: Hashable {}

extension GenericStateModel_CollapsedExpandedDisabled: Sendable where Value: Sendable {}

extension GenericStateModel_CollapsedExpandedDisabled {
    /// Maps state to model.
    public func value(for state: GenericState_CollapsedExpandedDisabled) -> Value {
        switch state {
        case .collapsed: collapsed
        case .expanded: expanded
        case .disabled: disabled
        }
    }
}
