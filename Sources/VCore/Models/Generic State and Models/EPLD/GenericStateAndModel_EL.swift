//
//  GenericState_EL.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Loading)
/// Enumeration that represents state, such as `enabled` or `loading`.
///
/// Used for mapping state to `GenericStateModel_EL`, via `value(for:)` method.
public enum GenericState_EL: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Loading.
    case loading
    
    // MARK: Initializers
    /// Initializes `GenericState_EL` with flag.
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
/// Used for mapping `GenericState_EL` to model, via `value(for:)` method.
public struct GenericStateModel_EL<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Loading value.
    public var loading: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EPL` with values.
    public init(
        enabled: Value,
        loading: Value
    ) {
        self.enabled = enabled
        self.loading = loading
    }
    
    /// Initializes `GenericStateModel_EPL` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.loading = value
    }
    
    /// Initializes `GenericStateModel_EPL` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EL<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_EPL` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EL<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_EL {
    /// Initializes `GenericStateModel_EL` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EL<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_EL {
    /// Initializes `GenericStateModel_EL` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EL<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_EL {
    /// Initializes `GenericStateModel_EL` with `GenericStateModel_ELD`.
    public init(_ model: GenericStateModel_ELD<Value>) {
        self.init(
            enabled: model.enabled,
            loading: model.loading
        )
    }

    /// Initializes `GenericStateModel_EL` with `GenericStateModel_EPLD`.
    public init(_ model: GenericStateModel_EPLD<Value>) {
        self.init(
            enabled: model.enabled,
            loading: model.loading
        )
    }
}

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_EL: Hashable where Value: Hashable {}

extension GenericStateModel_EL: Equatable where Value: Equatable {}

extension GenericStateModel_EL: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.loading)
    }
}

// MARK: - Mapping
extension GenericStateModel_EL {
    /// Maps `GenericState_EL` to `GenericStateModel_EL`.
    public func value(for state: GenericState_EL) -> Value {
        switch state {
        case .enabled: return enabled
        case .loading: return loading
        }
    }
}
