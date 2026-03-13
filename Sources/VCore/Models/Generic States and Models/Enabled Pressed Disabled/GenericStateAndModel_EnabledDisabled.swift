//
//  GenericStateAndModel_EnabledDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Enumeration that represents state.
public enum GenericState_EnabledDisabled: Int, Sendable, CaseIterable {
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

/// Model containing generic state-bound values.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_EnabledDisabled` with values."
)
public struct GenericStateModel_EnabledDisabled<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EnabledDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.disabled = value
    }

    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_EnabledDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledDisabled<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_EnabledDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledDisabled<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_EnabledDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledDisabled<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_EnabledDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledDisabled<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Initializers - Model Casting
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

    // MARK: Map
    /// Returns `GenericStateModel_EnabledDisabled`  containing the results of mapping the given closure over the values.
    public func map<NewValue>(
        _ transform: (Value) throws -> NewValue
    ) rethrows -> GenericStateModel_EnabledDisabled<NewValue> {
        .init(
            enabled: try transform(enabled),
            disabled: try transform(disabled)
        )
    }
}

extension GenericStateModel_EnabledDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_EnabledDisabled: Hashable where Value: Hashable {}

extension GenericStateModel_EnabledDisabled: Sendable where Value: Sendable {}

extension GenericStateModel_EnabledDisabled {
    /// Maps state to model.
    public func value(for state: GenericState_EnabledDisabled) -> Value {
        switch state {
        case .enabled: enabled
        case .disabled: disabled
        }
    }
}
