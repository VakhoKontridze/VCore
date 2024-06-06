//
//  GenericStateAndModel_DeselectedSelectedPressedDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze selected 01.04.23.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Generic State (Deselected, Selected, Pressed, Disabled)
/// Enumeration that represents state, such as `deselected`, `selected`, `pressed` (`deselected`), `pressed` (`selected`), or `disabled`.
///
/// Used for mapping state to `GenericStateModel_DeselectedSelectedPressedDisabled`, with `value(for:)` method.
public enum GenericState_DeselectedSelectedPressedDisabled: Int, CaseIterable {
    // MARK: Cases
    /// Deselected.
    case deselected
    
    /// Selected.
    case selected
    
    /// Pressed (deselected).
    case pressedDeselected
    
    /// Pressed (selected).
    case pressedSelected
    
    /// Disabled
    case disabled
    
    // MARK: Properties
    /// Indicates if gesture is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .deselected: true
        case .selected: true
        case .pressedDeselected: true
        case .pressedSelected: true
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_DeselectedSelectedPressedDisabled` with flags.
    public init(isEnabled: Bool, isSelected: Bool, isPressed: Bool) {
        switch (isEnabled, isSelected, isPressed) {
        case (false, _, _): self = .disabled
        case (true, false, false): self = .deselected
        case (true, false, true): self = .pressedDeselected
        case (true, true, false): self = .selected
        case (true, true, true): self = .pressedSelected
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .deselected, .pressedDeselected: self = .selected
        case .selected, .pressedSelected: self = .deselected
        case .disabled: break
        }
    }
}

// MARK: - Generic State Model (Deselected, Selected, Pressed, Disabled)
/// Value group containing `deselected`, `selected`, `pressed` (`deselected`), `pressed` (`selected`), and `disabled`.
///
/// Used for mapping `GenericState_DeselectedSelectedPressedDisabled` to model, with `value(for:)` method.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_DeselectedSelectedPressedDisabled` with values."
)
public struct GenericStateModel_DeselectedSelectedPressedDisabled<Value> {
    // MARK: Properties
    /// Deselected value.
    public var deselected: Value
    
    /// Selected value.
    public var selected: Value
    
    /// Pressed (deselected) value.
    public var pressedDeselected: Value
    
    /// Pressed (selected) value.
    public var pressedSelected: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_DeselectedSelectedPressedDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.deselected = value
        self.selected = value
        self.pressedDeselected = value
        self.pressedSelected = value
        self.disabled = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_DeselectedSelectedPressedDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_DeselectedSelectedPressedDisabled<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_DeselectedSelectedPressedDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_DeselectedSelectedPressedDisabled<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_DeselectedSelectedPressedDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_DeselectedSelectedPressedDisabled<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_DeselectedSelectedPressedDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_DeselectedSelectedPressedDisabled<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Map
    /// Returns `GenericStateModel_DeselectedSelectedPressedDisabled`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            deselected: try transform(deselected),
            selected: try transform(selected),
            pressedDeselected: try transform(pressedDeselected),
            pressedSelected: try transform(pressedSelected),
            disabled: try transform(disabled)
        )
    }
}

// MARK: Equatable, Hashable
extension GenericStateModel_DeselectedSelectedPressedDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_DeselectedSelectedPressedDisabled: Hashable where Value: Hashable {}

// MARK: - State-Model Mapping
extension GenericStateModel_DeselectedSelectedPressedDisabled {
    /// Maps `GenericState_DeselectedSelectedPressedDisabled` to `GenericStateModel_DeselectedSelectedPressedDisabled`.
    public func value(for state: GenericState_DeselectedSelectedPressedDisabled) -> Value {
        switch state {
        case .deselected: deselected
        case .selected: selected
        case .pressedDeselected: pressedDeselected
        case .pressedSelected: pressedSelected
        case .disabled: disabled
        }
    }
}
