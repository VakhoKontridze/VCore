//
//  GenericStateAndModel_ELD.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 3/10/22.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Loading, Disabled)
/// Enumeration that represents state, such as `enabled`, `loading`, or `disabled`.
///
/// Used for mapping state to `GenericStateModel_ELD`, via `value(for:)` method.
public enum GenericState_ELD: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Loading.
    case loading
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if interaction is enabled.
    public var isEnabled: Bool {
        switch self {
        case .enabled: return true
        case .loading: return false
        case .disabled: return false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_ELD` with flags.
    public init(isEnabled: Bool, isLoading: Bool) {
        switch (isEnabled, isLoading) {
        case (false, _): self = .disabled
        case (true, false): self = .enabled
        case (true, true): self = .loading
        }
    }
}

// MARK: - Generic State Model (Enabled, Loading, Disabled)
/// Value group containing generic `enabled`, `loading`, and `disabled` values.
///
/// Used for mapping `GenericState_ELD` to model, via `value(for:)` method.
public struct GenericStateModel_ELD<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Loading value.
    public var loading: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_ELD` with values.
    public init(
        enabled: Value,
        loading: Value,
        disabled: Value
    ) {
        self.enabled = enabled
        self.loading = loading
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_ELD` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.loading = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_ELD` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_ELD<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_ELD` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_ELD<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_ELD {
    /// Initializes `GenericStateModel_ELD` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_ELD<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_ELD {
    /// Initializes `GenericStateModel_ELD` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_ELD<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_ELD {
    /// Initializes `GenericStateModel_ELD` with `GenericStateModel_EPLD`.
    public init(_ model: GenericStateModel_EPLD<Value>) {
        self.init(
            enabled: model.enabled,
            loading: model.loading,
            disabled: model.disabled
        )
    }
}

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_ELD: Hashable where Value: Hashable {}

extension GenericStateModel_ELD: Equatable where Value: Equatable {}

extension GenericStateModel_ELD: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.loading, \.disabled)
    }
}

// MARK: - Mapping
extension GenericStateModel_ELD {
    /// Maps `GenericState_ELD` to `GenericStateModel_ELD`.
    public func value(for state: GenericState_ELD) -> Value {
        switch state {
        case .enabled: return enabled
        case .loading: return loading
        case .disabled: return disabled
        }
    }
}
