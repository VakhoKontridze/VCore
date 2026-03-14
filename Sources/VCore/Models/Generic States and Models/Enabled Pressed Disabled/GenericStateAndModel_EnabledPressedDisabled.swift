//
//  GenericStateAndModel_EnabledPressedDisabled.swift
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
public nonisolated enum GenericState_EnabledPressedDisabled: Int, Sendable, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if gesture is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .enabled: true
        case .pressed: true
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_EnabledPressedDisabled` with flags.
    public init(isEnabled: Bool, isPressed: Bool) {
        switch (isEnabled, isPressed) {
        case (false, _): self = .disabled
        case (true, false): self = .enabled
        case (true, true): self = .pressed
        }
    }
}

/// Model containing generic state-bound values.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_EnabledPressedDisabled` with values."
)
public nonisolated struct GenericStateModel_EnabledPressedDisabled<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Pressed value.
    public var pressed: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EnabledPressedDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
        self.disabled = value
    }

    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_EnabledPressedDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledPressedDisabled<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_EnabledPressedDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledPressedDisabled<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_EnabledPressedDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledPressedDisabled<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_EnabledPressedDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledPressedDisabled<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Initializers - Model Casting
    /// Initializes `GenericStateModel_EnabledPressedDisabled` with `GenericStateModel_EnabledPressedLoadingDisabled`.
    public init(_ model: GenericStateModel_EnabledPressedLoadingDisabled<Value>) {
        self.init(
            enabled: model.enabled,
            pressed: model.pressed,
            disabled: model.disabled
        )
    }

    /// Initializes `GenericStateModel_EnabledPressedDisabled` with `GenericStateModel_EnabledPressedFocusedDisabled`.
    public init(_ model: GenericStateModel_EnabledPressedFocusedDisabled<Value>) {
        self.init(
            enabled: model.enabled,
            pressed: model.pressed,
            disabled: model.disabled
        )
    }

    // MARK: Map
    /// Returns `GenericStateModel_EnabledPressedDisabled`  containing the results of mapping the given closure over the values.
    public func map<NewValue>(
        _ transform: (Value) throws -> NewValue
    ) rethrows -> GenericStateModel_EnabledPressedDisabled<NewValue> {
        .init(
            enabled: try transform(enabled),
            pressed: try transform(pressed),
            disabled: try transform(disabled)
        )
    }
}

nonisolated extension GenericStateModel_EnabledPressedDisabled: Equatable where Value: Equatable {}

nonisolated extension GenericStateModel_EnabledPressedDisabled: Hashable where Value: Hashable {}

nonisolated extension GenericStateModel_EnabledPressedDisabled: Sendable where Value: Sendable {}

nonisolated extension GenericStateModel_EnabledPressedDisabled {
    /// Maps state to model.
    public func value(for state: GenericState_EnabledPressedDisabled) -> Value {
        switch state {
        case .enabled: enabled
        case .pressed: pressed
        case .disabled: disabled
        }
    }
}
