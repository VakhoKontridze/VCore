//
//  GenericState_EnabledPressed.swift
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

// MARK: - Genetic State (Enabled, Pressed)
/// Enumeration that represents state, such as `enabled` or `pressed`.
///
/// Used for mapping state to `GenericStateModel_EnabledPressed`, with `value(for:)` method.
public enum GenericState_EnabledPressed: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    // MARK: Initializers
    /// Initializes `GenericState_EnabledPressed` with flag.
    public init(isPressed: Bool) {
        switch isPressed {
        case false: self = .enabled
        case true: self = .pressed
        }
    }
}

// MARK: - Generic State Model (Enabled, Pressed)
/// Value group containing generic `enabled` and `pressed` values.
///
/// Used for mapping `GenericState_EnabledPressed` to model, with `value(for:)` method.
@MemberwiseInitializable(
    accessLevelModifier: .public,
    comment: "/// Initializes `GenericStateModel_EnabledPressed` with values."
)
public struct GenericStateModel_EnabledPressed<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Pressed value.
    public var pressed: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EnabledPressed` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_EnabledPressed` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledPressed<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_EnabledPressed` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledPressed<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_EnabledPressed` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledPressed<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_EnabledPressed` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledPressed<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Map
    /// Returns `GenericStateModel_EnabledPressed`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            enabled: try transform(enabled),
            pressed: try transform(pressed)
        )
    }
}

// MARK: Equatable, Hashable
extension GenericStateModel_EnabledPressed: Equatable where Value: Equatable {}

extension GenericStateModel_EnabledPressed: Hashable where Value: Hashable {}

// MARK: - State-Model Mapping
extension GenericStateModel_EnabledPressed {
    /// Maps `GenericState_EnabledPressed` to `GenericStateModel_EnabledPressed`.
    public func value(for state: GenericState_EnabledPressed) -> Value {
        switch state {
        case .enabled: enabled
        case .pressed: pressed
        }
    }
}
