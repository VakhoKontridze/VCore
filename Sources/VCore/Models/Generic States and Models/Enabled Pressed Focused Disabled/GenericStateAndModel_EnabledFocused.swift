//
//  GenericState_EnabledFocused.swift
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

// MARK: - Genetic State (Enabled, Focused)
/// Enumeration that represents state, such as `enabled` or `focused`.
///
/// Used for mapping state to `GenericStateModel_EnabledFocused`, with `value(for:)` method.
public enum GenericState_EnabledFocused: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Focused.
    case focused
    
    // MARK: Initializers
    /// Initializes `GenericState_EnabledFocused` with flag.
    public init(isFocused: Bool) {
        switch isFocused {
        case false: self = .enabled
        case true: self = .focused
        }
    }
}

// MARK: - Generic State Model (Enabled, Focused)
/// Value group containing generic `enabled`  and `focused` values.
///
/// Used for mapping `GenericState_EnabledFocused` to model, with `value(for:)` method.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_EnabledFocused` with values."
)
public struct GenericStateModel_EnabledFocused<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Focused value.
    public var focused: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EnabledFocused` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.focused = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_EnabledFocused` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledFocused<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_EnabledPressedFocused` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledFocused<Color> {
        .init(.clear)
    }
    
#if canImport(UIKit)
    
    /// Initializes `GenericStateModel_EnabledFocused` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledFocused<UIColor> {
        .init(.clear)
    }
    
#elseif canImport(AppKit)
    
    /// Initializes `GenericStateModel_EnabledFocused` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledFocused<NSColor> {
        .init(.clear)
    }
    
#endif

    // MARK: Map
    /// Returns `GenericStateModel_EnabledPressedFocused`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            enabled: try transform(enabled),
            focused: try transform(focused)
        )
    }
}

// MARK: Equatable, Hashable
extension GenericStateModel_EnabledFocused: Equatable where Value: Equatable {}

extension GenericStateModel_EnabledFocused: Hashable where Value: Hashable {}

// MARK: - State-Model Mapping
extension GenericStateModel_EnabledFocused {
    /// Maps `GenericState_EnabledFocused` to `GenericStateModel_EnabledFocused`.
    public func value(for state: GenericState_EnabledFocused) -> Value {
        switch state {
        case .enabled: enabled
        case .focused: focused
        }
    }
}
