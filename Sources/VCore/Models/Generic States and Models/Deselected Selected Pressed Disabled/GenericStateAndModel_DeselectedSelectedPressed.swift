//
//  GenericStateAndModel_DeselectedSelectedPressed.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.04.23.
//

import SwiftUI

// MARK: - Generic State (Deselected, Selected, Pressed)
/// Enumeration that represents state, such as `deselected`, `selected`, `pressed` (`deselected`), or `pressed` (`selected`).
///
/// Used for mapping state to `GenericStateModel_DeselectedSelectedPressed`, via `value(for:)` method.
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
/// Color group containing `deselected`, `selected`, `pressed` (`deselected`), and `pressed` (`selected`).
///
/// Used for mapping `GenericState_DeselectedSelectedPressed` to model, via `value(for:)` method.
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
    /// Initializes `GenericStateModel_DeselectedSelectedPressed` with values.
    public init(
        deselected: Value,
        selected: Value,
        pressedDeselected: Value,
        pressedSelected: Value
    ) {
        self.deselected = deselected
        self.selected = selected
        self.pressedDeselected = pressedDeselected
        self.pressedSelected = pressedSelected
    }
    
    /// Initializes `GenericStateModel_DeselectedSelectedPressed` with values.
    public init(
        deselected: Value,
        selected: Value,
        pressed: Value
    ) {
        self.deselected = deselected
        self.selected = selected
        self.pressedDeselected = pressed
        self.pressedSelected = pressed
    }
    
    /// Initializes `GenericStateModel_DeselectedSelectedPressed` with value.
    public init(
        _ value: Value
    ) {
        self.deselected = value
        self.selected = value
        self.pressedDeselected = value
        self.pressedSelected = value
    }
    
    /// Initializes `GenericStateModel_DeselectedSelectedPressed` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_DeselectedSelectedPressed<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_DeselectedSelectedPressed` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_DeselectedSelectedPressed<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_DeselectedSelectedPressed {
    /// Initializes `GenericStateModel_DeselectedSelectedPressed` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_DeselectedSelectedPressed<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_DeselectedSelectedPressed {
    /// Initializes `GenericStateModel_DeselectedSelectedPressed` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_DeselectedSelectedPressed<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_DeselectedSelectedPressed {
    /// Initializes `GenericStateModel_DeselectedSelectedPressed` with `GenericStateModel_DeselectedSelectedPressedDisabled`.
    public init(_ model: GenericStateModel_DeselectedSelectedPressedDisabled<Value>) {
        self.init(
            deselected: model.deselected,
            selected: model.selected,
            pressedDeselected: model.pressedDeselected,
            pressedSelected: model.pressedSelected
        )
    }
}

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_DeselectedSelectedPressed: Hashable where Value: Hashable {}

extension GenericStateModel_DeselectedSelectedPressed: Equatable where Value: Equatable {}

extension GenericStateModel_DeselectedSelectedPressed: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.deselected, \.selected, \.pressedDeselected, \.pressedSelected)
    }
}

// MARK: - Mapping
extension GenericStateModel_DeselectedSelectedPressed {
    /// Maps `GenericState_DeselectedSelectedPressed` to `GenericStateModel_DeselectedSelectedPressed`.
    public func value(for state: GenericState_DeselectedSelectedPressed) -> Value {
        switch state {
        case .deselected: return deselected
        case .selected: return selected
        case .pressedDeselected: return pressedDeselected
        case .pressedSelected: return pressedSelected
        }
    }
}
