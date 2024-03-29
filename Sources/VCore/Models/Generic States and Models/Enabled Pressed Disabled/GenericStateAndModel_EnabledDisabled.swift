//
//  GenericStateAndModel_EnabledDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Disabled)
/// Enumeration that represents state, such as `enabled` or `disabled`.
///
/// Used for mapping state to `GenericStateModel_EnabledDisabled`, via `value(for:)` method.
public enum GenericState_EnabledDisabled: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if gesture is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .enabled: true
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes`GenericState_EnabledPressedDisabled` with flag.
    public init(isEnabled: Bool) {
        switch isEnabled {
        case false: self = .disabled
        case true: self = .enabled
        }
    }
}

// MARK: - Generic State Model (Enabled, Disabled)
/// Value group containing generic `enabled` and `disabled` values.
///
/// Used for mapping `GenericState_EnabledDisabled` to model, via `value(for:)` method.
public struct GenericStateModel_EnabledDisabled<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EnabledDisabled` with values.
    public init(
        enabled: Value,
        disabled: Value
    ) {
        self.enabled = enabled
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_EnabledDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_EnabledDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledDisabled<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_EnabledDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledDisabled<Color> {
        .init(.clear)
    }

    // MARK: Map
    /// Returns `GenericStateModel_EnabledDisabled`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            enabled: try transform(enabled),
            disabled: try transform(disabled)
        )
    }
}

// MARK: Platform-Specific Initializers
#if canImport(UIKit)

import UIKit

extension GenericStateModel_EnabledDisabled {
    /// Initializes `GenericStateModel_EnabledDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledDisabled<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_EnabledDisabled {
    /// Initializes `GenericStateModel_EnabledDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledDisabled<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_EnabledDisabled {
    /// Initializes `GenericStateModel_EnabledDisabled` with `GenericStateModel_EnabledPressedDisabled`.
    public init(_ model: GenericStateModel_EnabledPressedDisabled<Value>) {
        self.init(
            enabled: model.enabled,
            disabled: model.disabled
        )
    }

    /// Initializes `GenericStateModel_EnabledDisabled` with `GenericStateModel_EnabledFocusedDisabled`.
    public init(_ model: GenericStateModel_EnabledFocusedDisabled<Value>) {
        self.init(
            enabled: model.enabled,
            disabled: model.disabled
        )
    }

    /// Initializes `GenericStateModel_EnabledDisabled` with `GenericStateModel_EnabledPressedLoadingDisabled`.
    public init(_ model: GenericStateModel_EnabledPressedLoadingDisabled<Value>) {
        self.init(
            enabled: model.enabled,
            disabled: model.disabled
        )
    }

    /// Initializes `GenericStateModel_EnabledDisabled` with `GenericStateModel_EnabledPressedFocusedDisabled`.
    public init(_ model: GenericStateModel_EnabledPressedFocusedDisabled<Value>) {
        self.init(
            enabled: model.enabled,
            disabled: model.disabled
        )
    }
}

// MARK: Equatable, Hashable, Comparable
extension GenericStateModel_EnabledDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_EnabledDisabled: Hashable where Value: Hashable {}

extension GenericStateModel_EnabledDisabled: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.disabled)
    }
}

// MARK: - State-Model Mapping
extension GenericStateModel_EnabledDisabled {
    /// Maps `GenericState_EnabledDisabled` to `GenericStateModel_EnabledDisabled`.
    public func value(for state: GenericState_EnabledDisabled) -> Value {
        switch state {
        case .enabled: enabled
        case .disabled: disabled
        }
    }
}
