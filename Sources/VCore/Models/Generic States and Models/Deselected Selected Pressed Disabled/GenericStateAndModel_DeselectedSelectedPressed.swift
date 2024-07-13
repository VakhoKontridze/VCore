//
//  GenericStateAndModel_DeselectedSelectedPressed.swift
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

// MARK: - Generic State (Deselected, Selected, Pressed)
/// Enumeration that represents state.
///
/// Used for mapping state to `GenericStateModel_DeselectedSelectedPressed`, with `value(for:)` method.
public enum GenericState_DeselectedSelectedPressed: Int, CaseIterable {
    // MARK: Cases
    /// Deselected.
    case deselected
    
    /// Selected.
    case selected
    
    /// Pressed (deselected).
    case pressedDeselected
    
    /// Pressed (selected).
    case pressedSelected
        
    // MARK: Initializers
    /// Initializes `GenericState_DeselectedSelectedPressed` with flags.
    public init(isSelected: Bool, isPressed: Bool) {
        switch (isSelected, isPressed) {
        case (false, false): self = .deselected
        case (false, true): self = .pressedDeselected
        case (true, false): self = .selected
        case (true, true): self = .pressedSelected
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .deselected, .pressedDeselected: self = .selected
        case .selected, .pressedSelected: self = .deselected
        }
    }
}

// MARK: - Generic State Model (Deselected, Selected, Pressed)
/// Value group containing `deselected`, `selected`, `pressed` (`deselected`), and `pressed` (`selected`).
///
/// Used for mapping `GenericState_DeselectedSelectedPressed` to model, with `value(for:)` method.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_DeselectedSelectedPressed` with values."
)
public struct GenericStateModel_DeselectedSelectedPressed<Value> {
    // MARK: Properties
    /// Deselected value.
    public var deselected: Value
    
    /// Selected value.
    public var selected: Value
    
    /// Pressed (deselected) value.
    public var pressedDeselected: Value
    
    /// Pressed (selected) value.
    public var pressedSelected: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_DeselectedSelectedPressed` with value.
    public init(
        _ value: Value
    ) {
        self.deselected = value
        self.selected = value
        self.pressedDeselected = value
        self.pressedSelected = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_DeselectedSelectedPressed` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_DeselectedSelectedPressed<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_DeselectedSelectedPressed` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_DeselectedSelectedPressed<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_DeselectedSelectedPressed` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_DeselectedSelectedPressed<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_DeselectedSelectedPressed` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_DeselectedSelectedPressed<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Initializers - Model Casting
    /// Initializes `GenericStateModel_DeselectedSelectedPressed` with `GenericStateModel_DeselectedSelectedPressedDisabled`.
    public init(_ model: GenericStateModel_DeselectedSelectedPressedDisabled<Value>) {
        self.init(
            deselected: model.deselected,
            selected: model.selected,
            pressedDeselected: model.pressedDeselected,
            pressedSelected: model.pressedSelected
        )
    }

    // MARK: Map
    /// Returns `GenericStateModel_DeselectedSelectedPressed`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            deselected: try transform(deselected),
            selected: try transform(selected),
            pressedDeselected: try transform(pressedDeselected),
            pressedSelected: try transform(pressedSelected)
        )
    }
}

// MARK: Equatable, Hashable
extension GenericStateModel_DeselectedSelectedPressed: Equatable where Value: Equatable {}

extension GenericStateModel_DeselectedSelectedPressed: Hashable where Value: Hashable {}

// MARK: - State-Model Mapping
extension GenericStateModel_DeselectedSelectedPressed {
    /// Maps `GenericState_DeselectedSelectedPressed` to `GenericStateModel_DeselectedSelectedPressed`.
    public func value(for state: GenericState_DeselectedSelectedPressed) -> Value {
        switch state {
        case .deselected: deselected
        case .selected: selected
        case .pressedDeselected: pressedDeselected
        case .pressedSelected: pressedSelected
        }
    }
}
