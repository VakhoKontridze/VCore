//
//  GenericState_EF.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Focused)
/// Enumeration that represents state, such as `enabled` or `focused`.
///
/// Used for mapping state to `GenericStateModel_EF`, via `value(for:)` method.
public enum GenericState_EF: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Focused.
    case focused
    
    // MARK: Initializers
    /// Initializes `GenericState_EF` with flag.
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
/// Used for mapping `GenericState_EF` to model, via `value(for:)` method.
public struct GenericStateModel_EF<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Focused value.
    public var focused: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EPF` with values.
    public init(
        enabled: Value,
        pressed: Value,
        focused: Value
    ) {
        self.enabled = enabled
        self.focused = focused
    }
    
    /// Initializes `GenericStateModel_EPF` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.focused = value
    }
    
    /// Initializes `GenericStateModel_EPF` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EF<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_EPF` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EF<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_EF {
    /// Initializes `GenericStateModel_EF` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EF<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_EF {
    /// Initializes `GenericStateModel_EF` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EF<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_EF: Hashable where Value: Hashable {}

extension GenericStateModel_EF: Equatable where Value: Equatable {}

extension GenericStateModel_EF: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.focused)
    }
}

// MARK: - Mapping
extension GenericStateModel_EF {
    /// Maps `GenericState_EF` to `GenericStateModel_EF`.
    public func value(for state: GenericState_EF) -> Value {
        switch state {
        case .enabled: return enabled
        case .focused: return focused
        }
    }
}
