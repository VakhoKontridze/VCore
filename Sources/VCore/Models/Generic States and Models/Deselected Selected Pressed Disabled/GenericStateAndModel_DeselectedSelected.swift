//
//  GenericStateAndModel_DeselectedSelected.swift
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
/// Used for mapping state to `GenericStateModel_DeselectedSelected`, with `value(for:)` method.
public enum GenericState_DeselectedSelected: Int, CaseIterable {
    // MARK: Cases
    /// Deselected.
    case deselected
    
    /// Selected.
    case selected
    
    // MARK: Initializers
    /// Initializes `GenericState_DeselectedSelected` with flags.
    public init(isSelected: Bool) {
        switch isSelected {
        case false: self = .deselected
        case true: self = .selected
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .deselected: self = .selected
        case .selected: self = .deselected
        }
    }
}

// MARK: - Binding + Initializer
extension Binding where Value == GenericState_DeselectedSelected {
    /// Initializes `GenericState_DeselectedSelected` with `Bool`.
    public init(isSelected: Binding<Bool>) {
        self.init(
            get: { GenericState_DeselectedSelected(isSelected: isSelected.wrappedValue) },
            set: { isSelected.wrappedValue = $0 == .selected }
        )
    }
}

// MARK: - Generic State Model (Deselected, Selected)
/// Value group containing `deselected` and `selected`.
///
/// Used for mapping `GenericState_DeselectedSelected` to model, with `value(for:)` method.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_DeselectedSelected` with values."
)
public struct GenericStateModel_DeselectedSelected<Value> {
    // MARK: Properties
    /// Deselected value.
    public var deselected: Value
    
    /// Selected value.
    public var selected: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_DeselectedSelected` with value.
    public init(
        _ value: Value
    ) {
        self.deselected = value
        self.selected = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_DeselectedSelected` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_DeselectedSelected<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_DeselectedSelected` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_DeselectedSelected<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_DeselectedSelected` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_DeselectedSelected<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_DeselectedSelected` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_DeselectedSelected<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Initializers - Model-Casting
    /// Initializes `GenericStateModel_DeselectedSelected` with `GenericStateModel_DeselectedSelectedDisabled`.
    public init(_ model: GenericStateModel_DeselectedSelectedDisabled<Value>) {
        self.init(
            deselected: model.deselected,
            selected: model.selected
        )
    }

    /// Initializes `GenericStateModel_DeselectedSelected` with `GenericStateModel_DeselectedSelectedPressed`.
    public init(_ model: GenericStateModel_DeselectedSelectedPressed<Value>) {
        self.init(
            deselected: model.deselected,
            selected: model.selected
        )
    }

    /// Initializes `GenericStateModel_DeselectedSelected` with `GenericStateModel_DeselectedSelectedPressedDisabled`.
    public init(_ model: GenericStateModel_DeselectedSelectedPressedDisabled<Value>) {
        self.init(
            deselected: model.deselected,
            selected: model.selected
        )
    }

    // MARK: Map
    /// Returns `GenericStateModel_DeselectedSelected`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            deselected: try transform(deselected),
            selected: try transform(selected)
        )
    }
}

// MARK: Equatable, Hashable
extension GenericStateModel_DeselectedSelected: Equatable where Value: Equatable {}

extension GenericStateModel_DeselectedSelected: Hashable where Value: Hashable {}

// MARK: - State-Model Mapping
extension GenericStateModel_DeselectedSelected {
    /// Maps `GenericState_DeselectedSelected` to `GenericStateModel_DeselectedSelected`.
    public func value(for state: GenericState_DeselectedSelected) -> Value {
        switch state {
        case .deselected: deselected
        case .selected: selected
        }
    }
}

