//
//  GenericStateAndModel_DeselectedSelectedDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.04.23.
//

import SwiftUI

// MARK: - Generic State (Deselected, Selected, Disabled)
/// Enumeration that represents state, such as `deselected`, `selected`, or `disabled`.
///
/// Used for mapping state to `GenericStateModel_DeselectedSelectedDisabled`, via `value(for:)` method.
public enum GenericState_DeselectedSelectedDisabled: Int, CaseIterable {
    // MARK: Cases
    /// Deselected.
    case deselected
    
    /// Selected.
    case selected
    
    /// Disabled
    case disabled
    
    // MARK: Properties
    /// Indicates if interaction is enabled.
    public var isEnabled: Bool {
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
/// Used for mapping `GenericState_DeselectedSelectedDisabled` to model, via `value(for:)` method.
public struct GenericStateModel_DeselectedSelectedDisabled<Value> {
    // MARK: Properties
    /// Deselected value.
    public var deselected: Value
    
    /// Selected value.
    public var selected: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_DeselectedSelectedDisabled` with values.
    public init(
        deselected: Value,
        selected: Value,
        disabled: Value
    ) {
        self.deselected = deselected
        self.selected = selected
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_DeselectedSelectedDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.deselected = value
        self.selected = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_DeselectedSelectedDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_DeselectedSelectedDisabled<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_DeselectedSelectedDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_DeselectedSelectedDisabled<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializers
#if canImport(UIKit)

import UIKit

extension GenericStateModel_DeselectedSelectedDisabled {
    /// Initializes `GenericStateModel_DeselectedSelectedDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_DeselectedSelectedDisabled<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_DeselectedSelectedDisabled {
    /// Initializes `GenericStateModel_DeselectedSelectedDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_DeselectedSelectedDisabled<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_DeselectedSelectedDisabled {
    /// Initializes `GenericStateModel_DeselectedSelectedDisabled` with `GenericStateModel_DeselectedSelectedPressedDisabled`.
    public init(_ model: GenericStateModel_DeselectedSelectedPressedDisabled<Value>) {
        self.init(
            deselected: model.deselected,
            selected: model.selected,
            disabled: model.disabled
        )
    }
}

// MARK: Equatable, Hashable, Comparable
extension GenericStateModel_DeselectedSelectedDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_DeselectedSelectedDisabled: Hashable where Value: Hashable {}

extension GenericStateModel_DeselectedSelectedDisabled: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.deselected, \.selected, \.disabled)
    }
}

// MARK: - Mapping
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
