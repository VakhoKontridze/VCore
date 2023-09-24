//
//  GenericStateAndModel_EnabledPressedLoadingDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 3/10/22.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Pressed, Loading, Disabled)
/// Enumeration that represents state, such as `enabled`, `pressed`, `loading`, or `disabled`.
///
/// Used for mapping state to `GenericStateModel_EnabledPressedLoadingDisabled`, via `value(for:)` method.
public enum GenericState_EnabledPressedLoadingDisabled: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    /// Loading.
    case loading
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if gesture is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .enabled: true
        case .pressed: true
        case .loading: false
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_EnabledPressedLoadingDisabled` with flags.
    public init(isEnabled: Bool, isPressed: Bool, isLoading: Bool) {
        switch (isEnabled, isPressed, isLoading) {
        case (false, _, _): self = .disabled
        case (true, false, false): self = .enabled
        case (true, true, false): self = .pressed
        case (true, _, true): self = .loading
        }
    }
}

// MARK: - Generic State Model (Enabled, Pressed, Loading, Disabled)
/// Value group containing generic `enabled`, `pressed`, `loading`, and `disabled` values.
///
/// Used for mapping `GenericState_EnabledPressedLoadingDisabled` to model, via `value(for:)` method.
public struct GenericStateModel_EnabledPressedLoadingDisabled<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Pressed value.
    public var pressed: Value
    
    /// Loading value.
    public var loading: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EnabledPressedLoadingDisabled` with values.
    public init(
        enabled: Value,
        pressed: Value,
        loading: Value,
        disabled: Value
    ) {
        self.enabled = enabled
        self.pressed = pressed
        self.loading = loading
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_EnabledPressedLoadingDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
        self.loading = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_EnabledPressedLoadingDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledPressedLoadingDisabled<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_EnabledPressedLoadingDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledPressedLoadingDisabled<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializers
#if canImport(UIKit)

import UIKit

extension GenericStateModel_EnabledPressedLoadingDisabled {
    /// Initializes `GenericStateModel_EnabledPressedLoadingDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledPressedLoadingDisabled<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_EnabledPressedLoadingDisabled {
    /// Initializes `GenericStateModel_EnabledPressedLoadingDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledPressedLoadingDisabled<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Equatable, Hashable, Comparable
extension GenericStateModel_EnabledPressedLoadingDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_EnabledPressedLoadingDisabled: Hashable where Value: Hashable {}

extension GenericStateModel_EnabledPressedLoadingDisabled: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.pressed, \.loading, \.disabled)
    }
}

// MARK: - Mapping
extension GenericStateModel_EnabledPressedLoadingDisabled {
    /// Maps `GenericState_EnabledPressedLoadingDisabled` to `GenericStateModel_EnabledPressedLoadingDisabled`.
    public func value(for state: GenericState_EnabledPressedLoadingDisabled) -> Value {
        switch state {
        case .enabled: enabled
        case .pressed: pressed
        case .loading: loading
        case .disabled: disabled
        }
    }
}
