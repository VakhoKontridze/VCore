//
//  GenericStateAndModel_EnabledFocusedDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 3/10/22.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Genetic State (Enabled, Focused, Disabled)
/// Enumeration that represents state, such as `enabled`, `focused`, or `disabled`.
///
/// Used for mapping state to `GenericStateModel_EnabledFocusedDisabled`, with `value(for:)` method.
public enum GenericState_EnabledFocusedDisabled: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Focused.
    case focused
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if gesture is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .enabled: true
        case .focused: true
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_EnabledFocusedDisabled` with flags.
    public init(isEnabled: Bool, isFocused: Bool) {
        switch (isEnabled, isFocused) {
        case (false, _): self = .disabled
        case (true, false): self = .enabled
        case (true, true): self = .focused
        }
    }
}

// MARK: - Generic State Model (Enabled, Focused, Disabled)
/// Value group containing generic `enabled`, `focused`, and `disabled` values.
///
/// Used for mapping `GenericState_EnabledFocusedDisabled` to model, with `value(for:)` method.
public struct GenericStateModel_EnabledFocusedDisabled<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Focused value.
    public var focused: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EnabledFocusedDisabled` with values.
    public init(
        enabled: Value,
        focused: Value,
        disabled: Value
    ) {
        self.enabled = enabled
        self.focused = focused
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_EnabledFocusedDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.focused = value
        self.disabled = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_EnabledFocusedDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledFocusedDisabled<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_EnabledFocusedDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledFocusedDisabled<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_EnabledFocusedDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledFocusedDisabled<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_EnabledFocusedDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledFocusedDisabled<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Initializers - Model Casting
    /// Initializes `GenericStateModel_EnabledFocusedDisabled` with `GenericStateModel_EnabledPressedFocusedDisabled`.
    public init(_ model: GenericStateModel_EnabledPressedFocusedDisabled<Value>) {
        self.init(
            enabled: model.enabled,
            focused: model.focused,
            disabled: model.disabled
        )
    }

    // MARK: Map
    /// Returns `GenericStateModel_EnabledFocusedDisabled`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            enabled: try transform(enabled),
            focused: try transform(focused),
            disabled: try transform(disabled)
        )
    }
}

// MARK: Equatable, Hashable
extension GenericStateModel_EnabledFocusedDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_EnabledFocusedDisabled: Hashable where Value: Hashable {}

// MARK: - State-Model Mapping
extension GenericStateModel_EnabledFocusedDisabled {
    /// Maps `GenericState_EnabledFocusedDisabled` to `GenericStateModel_EnabledFocusedDisabled`.
    public func value(for state: GenericState_EnabledFocusedDisabled) -> Value {
        switch state {
        case .enabled: enabled
        case .focused: focused
        case .disabled: disabled
        }
    }
}
