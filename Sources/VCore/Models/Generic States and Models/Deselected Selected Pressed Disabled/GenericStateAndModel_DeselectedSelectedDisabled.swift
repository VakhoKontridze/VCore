//
//  GenericStateAndModel_DeselectedSelectedDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.04.23.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Generic State (Deselected, Selected, Disabled)
/// Enumeration that represents state.
///
/// Used for mapping state to `GenericStateModel_DeselectedSelectedDisabled`, with `value(for:)` method.
public enum GenericState_DeselectedSelectedDisabled: Int, CaseIterable {
    // MARK: Cases
    /// Deselected.
    case deselected
    
    /// Selected.
    case selected
    
    /// Disabled
    case disabled
    
    // MARK: Properties
    /// Indicates if gesture is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .deselected: true
        case .selected: true
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_DeselectedSelectedDisabled` with flags.
    public init(isEnabled: Bool, isSelected: Bool) {
        switch (isEnabled, isSelected) {
        case (false, _): self = .disabled
        case (true, false): self = .deselected
        case (true, true): self = .selected
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .deselected: self = .selected
        case .selected: self = .deselected
        case .disabled: break
        }
    }
}

// MARK: - Generic State Model (Deselected, Selected, Disabled)
/// Value group containing `deselected`, `selected`, and `disabled`.
///
/// Used for mapping `GenericState_DeselectedSelectedDisabled` to model, with `value(for:)` method.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_DeselectedSelectedDisabled` with values."
)
public struct GenericStateModel_DeselectedSelectedDisabled<Value> {
    // MARK: Properties
    /// Deselected value.
    public var deselected: Value
    
    /// Selected value.
    public var selected: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_DeselectedSelectedDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.deselected = value
        self.selected = value
        self.disabled = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_DeselectedSelectedDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_DeselectedSelectedDisabled<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_DeselectedSelectedDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_DeselectedSelectedDisabled<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_DeselectedSelectedDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_DeselectedSelectedDisabled<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_DeselectedSelectedDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_DeselectedSelectedDisabled<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Initializers - Model Casting
    /// Initializes `GenericStateModel_DeselectedSelectedDisabled` with `GenericStateModel_DeselectedSelectedPressedDisabled`.
    public init(_ model: GenericStateModel_DeselectedSelectedPressedDisabled<Value>) {
        self.init(
            deselected: model.deselected,
            selected: model.selected,
            disabled: model.disabled
        )
    }

    // MARK: Map
    /// Returns `GenericStateModel_DeselectedSelectedDisabled`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            deselected: try transform(deselected),
            selected: try transform(selected),
            disabled: try transform(disabled)
        )
    }
}

// MARK: Equatable, Hashable
extension GenericStateModel_DeselectedSelectedDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_DeselectedSelectedDisabled: Hashable where Value: Hashable {}

// MARK: - State-Model Mapping
extension GenericStateModel_DeselectedSelectedDisabled {
    /// Maps `GenericState_DeselectedSelectedDisabled` to `GenericStateModel_DeselectedSelectedDisabled`.
    public func value(for state: GenericState_DeselectedSelectedDisabled) -> Value {
        switch state {
        case .deselected: deselected
        case .selected: selected
        case .disabled: disabled
        }
    }
}
