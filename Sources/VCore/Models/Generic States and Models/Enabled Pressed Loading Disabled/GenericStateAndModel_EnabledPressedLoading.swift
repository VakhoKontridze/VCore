//
//  GenericState_EnabledPressedLoading.swift
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

// MARK: - Genetic State (Enabled, Pressed, Loading)
/// Enumeration that represents state, such as `enabled`, `pressed`, or `loading`.
///
/// Used for mapping state to `GenericStateModel_EnabledPressedLoading`, with `value(for:)` method.
public enum GenericState_EnabledPressedLoading: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    /// Loading.
    case loading
    
    /// Indicates if gesture is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .enabled: true
        case .pressed: true
        case .loading: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_EnabledPressedLoading` with flags.
    public init(isPressed: Bool, isLoading: Bool) {
        switch (isPressed, isLoading) {
        case (false, false): self = .enabled
        case (true, false): self = .pressed
        case (_, true): self = .loading
        }
    }
}

// MARK: - Generic State Model (Enabled, Pressed, Loading)
/// Value group containing generic `enabled`, `pressed`, and `loading` values.
///
/// Used for mapping `GenericState_EnabledPressedLoading` to model, with `value(for:)` method.
public struct GenericStateModel_EnabledPressedLoading<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Pressed value.
    public var pressed: Value
    
    /// Loading value.
    public var loading: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EnabledPressedLoading` with values.
    public init(
        enabled: Value,
        pressed: Value,
        loading: Value
    ) {
        self.enabled = enabled
        self.pressed = pressed
        self.loading = loading
    }
    
    /// Initializes `GenericStateModel_EnabledPressedLoading` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
        self.loading = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_EnabledPressedLoading` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledPressedLoading<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_EnabledPressedLoading` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledPressedLoading<Color> {
        .init(.clear)
    }

#if canImport(UIKit)
    /// Initializes `GenericStateModel_EnabledPressedLoading` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledPressedLoading<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_EnabledPressedLoading` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledPressedLoading<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Initializers - Model Casting
    /// Initializes `GenericStateModel_EnabledPressedLoading` with `GenericStateModel_EnabledPressedLoadingDisabled`.
    public init(_ model: GenericStateModel_EnabledPressedLoadingDisabled<Value>) {
        self.init(
            enabled: model.enabled,
            pressed: model.pressed,
            loading: model.loading
        )
    }

    // MARK: Map
    /// Returns `GenericStateModel_EnabledPressedLoading`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            enabled: try transform(enabled),
            pressed: try transform(pressed),
            loading: try transform(loading)
        )
    }
}

// MARK: Equatable, Hashable
extension GenericStateModel_EnabledPressedLoading: Equatable where Value: Equatable {}

extension GenericStateModel_EnabledPressedLoading: Hashable where Value: Hashable {}

// MARK: - State-Model Mapping
extension GenericStateModel_EnabledPressedLoading {
    /// Maps `GenericState_EnabledPressedLoading` to `GenericStateModel_EnabledPressedLoading`.
    public func value(for state: GenericState_EnabledPressedLoading) -> Value {
        switch state {
        case .enabled: enabled
        case .pressed: pressed
        case .loading: loading
        }
    }
}
