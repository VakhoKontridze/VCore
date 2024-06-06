//
//  GenericState_EnabledPressedFocused.swift
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

// MARK: - Genetic State (Enabled, Pressed, Focused)
/// Enumeration that represents state, such as `enabled`, `pressed`, or `focused`.
///
/// Used for mapping state to `GenericStateModel_EnabledPressedFocused`, with `value(for:)` method.
public enum GenericState_EnabledPressedFocused: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    /// Focused.
    case focused
    
    // MARK: Initializers
    /// Initializes `GenericState_EnabledPressedFocused` with flags.
    public init(isPressed: Bool, isFocused: Bool) {
        switch (isPressed, isFocused) {
        case (false, false): self = .enabled
        case (true, false): self = .pressed
        case (_, true): self = .focused
        }
    }
}

// MARK: - Generic State Model (Enabled, Pressed, Focused)
/// Value group containing generic `enabled`, `pressed`, and `focused` values.
///
/// Used for mapping `GenericState_EnabledPressedFocused` to model, with `value(for:)` method.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_EnabledPressedFocused` with values."
)
public struct GenericStateModel_EnabledPressedFocused<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Pressed value.
    public var pressed: Value
    
    /// Focused value.
    public var focused: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EnabledPressedFocused` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
        self.focused = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_EnabledPressedFocused` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledPressedFocused<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_EnabledPressedFocused` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledPressedFocused<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_EnabledPressedFocused` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledPressedFocused<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_EnabledPressedFocused` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledPressedFocused<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Initializers - Model Casting
    /// Initializes `GenericStateModel_EnabledPressedFocused` with `GenericStateModel_EnabledPressedFocusedDisabled`.
    public init(_ model: GenericStateModel_EnabledPressedFocusedDisabled<Value>) {
        self.init(
            enabled: model.enabled,
            pressed: model.pressed,
            focused: model.focused
        )
    }

    // MARK: Map
    /// Returns `GenericStateModel_EnabledPressedFocused`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            enabled: try transform(enabled),
            pressed: try transform(pressed),
            focused: try transform(focused)
        )
    }
}

// MARK: Equatable, Hashable
extension GenericStateModel_EnabledPressedFocused: Equatable where Value: Equatable {}

extension GenericStateModel_EnabledPressedFocused: Hashable where Value: Hashable {}

// MARK: - State-Model Mapping
extension GenericStateModel_EnabledPressedFocused {
    /// Maps `GenericState_EnabledPressedFocused` to `GenericStateModel_EnabledPressedFocused`.
    public func value(for state: GenericState_EnabledPressedFocused) -> Value {
        switch state {
        case .enabled: enabled
        case .pressed: pressed
        case .focused: focused
        }
    }
}
