//
//  GenericState_EnabledLoading.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Loading)
/// Enumeration that represents state, such as `enabled` or `loading`.
///
/// Used for mapping state to `GenericStateModel_EnabledLoading`, via `value(for:)` method.
public enum GenericState_EnabledLoading: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Loading.
    case loading
    
    // MARK: Initializers
    /// Initializes `GenericState_EnabledLoading` with flag.
    public init(isLoading: Bool) {
        switch isLoading {
        case false: self = .enabled
        case true: self = .loading
        }
    }
}

// MARK: - Generic State Model (Enabled, Loading)
/// Value group containing generic `enabled`  and `loading` values.
///
/// Used for mapping `GenericState_EnabledLoading` to model, via `value(for:)` method.
public struct GenericStateModel_EnabledLoading<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Loading value.
    public var loading: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EnabledLoading` with values.
    public init(
        enabled: Value,
        loading: Value
    ) {
        self.enabled = enabled
        self.loading = loading
    }
    
    /// Initializes `GenericStateModel_EnabledLoading` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.loading = value
    }
    
    /// Initializes `GenericStateModel_EnabledPressedLoading` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledLoading<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_EnabledPressedLoading` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledLoading<Color> {
        .init(.clear)
    }

    // MARK: Map
    /// Returns `GenericStateModel_EnabledPressedLoading`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            enabled: try transform(enabled),
            loading: try transform(loading)
        )
    }
}

// MARK: Platform-Specific Initializers
#if canImport(UIKit)

import UIKit

extension GenericStateModel_EnabledLoading {
    /// Initializes `GenericStateModel_EnabledLoading` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledLoading<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_EnabledLoading {
    /// Initializes `GenericStateModel_EnabledLoading` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledLoading<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Equatable, Hashable, Comparable
extension GenericStateModel_EnabledLoading: Equatable where Value: Equatable {}

extension GenericStateModel_EnabledLoading: Hashable where Value: Hashable {}

extension GenericStateModel_EnabledLoading: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.loading)
    }
}

// MARK: - State-Model Mapping
extension GenericStateModel_EnabledLoading {
    /// Maps `GenericState_EnabledLoading` to `GenericStateModel_EnabledLoading`.
    public func value(for state: GenericState_EnabledLoading) -> Value {
        switch state {
        case .enabled: enabled
        case .loading: loading
        }
    }
}
