//
//  GenericState_EPL.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Pressed, Loading)
/// Enumeration that represents state, such as `enabled`, `pressed`, or `loading`.
///
/// Used for mapping state to `GenericStateModel_EPL`, via `value(for:)` method.
public enum GenericState_EPL: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    /// Loading.
    case loading
    
    /// Indicates if interaction is enabled.
    public var isEnabled: Bool {
        switch self {
        case .enabled: return true
        case .pressed: return true
        case .loading: return false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_EPL` with flags.
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
/// Used for mapping `GenericState_EPL` to model, via `value(for:)` method.
public struct GenericStateModel_EPL<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Pressed value.
    public var pressed: Value
    
    /// Loading value.
    public var loading: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EPL` with values.
    public init(
        enabled: Value,
        pressed: Value,
        loading: Value
    ) {
        self.enabled = enabled
        self.pressed = pressed
        self.loading = loading
    }
    
    /// Initializes `GenericStateModel_EPL` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
        self.loading = value
    }
    
    /// Initializes `GenericStateModel_EPL` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EPL<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_EPL` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EPL<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_EPL {
    /// Initializes `GenericStateModel_EPL` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EPL<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_EPL {
    /// Initializes `GenericStateModel_EPL` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EPL<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_EPL: Hashable where Value: Hashable {}

extension GenericStateModel_EPL: Equatable where Value: Equatable {}

extension GenericStateModel_EPL: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.pressed, \.loading)
    }
}

// MARK: - Mapping
extension GenericStateModel_EPL {
    /// Maps `GenericState_EPL` to `GenericStateModel_EPL`.
    public func value(for state: GenericState_EPL) -> Value {
        switch state {
        case .enabled: return enabled
        case .pressed: return pressed
        case .loading: return loading
        }
    }
}
