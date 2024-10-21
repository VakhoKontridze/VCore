//
//  GenericState_EnabledLoading.swift
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

// MARK: - Genetic State (Enabled, Loading)
/// Enumeration that represents state.
///
/// Used for mapping state to `GenericStateModel_EnabledLoading`, with `value(for:)` method.
public enum GenericState_EnabledLoading: Int, Sendable, CaseIterable {
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
/// Used for mapping `GenericState_EnabledLoading` to model, with `value(for:)` method.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_EnabledLoading` with values."
)
public struct GenericStateModel_EnabledLoading<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Loading value.
    public var loading: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EnabledLoading` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.loading = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_EnabledPressedLoading` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledLoading<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_EnabledPressedLoading` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledLoading<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_EnabledLoading` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledLoading<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_EnabledLoading` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledLoading<NSColor> {
        .init(.clear)
    }

#endif

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

// MARK: Equatable, Hashable
extension GenericStateModel_EnabledLoading: Equatable where Value: Equatable {}

extension GenericStateModel_EnabledLoading: Hashable where Value: Hashable {}

// MARK: Sendable
extension GenericStateModel_EnabledLoading: Sendable where Value: Sendable {}

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
