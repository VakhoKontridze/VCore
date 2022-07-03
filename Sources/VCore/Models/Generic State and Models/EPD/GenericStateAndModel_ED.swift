//
//  GenericStateAndModel_ED.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Disabled)
/// Enumeration that represents state, such as `enabled` or `disabled`.
public enum GenericState_ED: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if interaction is enabled.
    public var isEnabled: Bool {
        switch self {
        case .enabled: return true
        case .disabled: return false
        }
    }
    
    // MARK: Initializers
    /// Initializes`GenericState_EPD` with flag.
    public init(isEnabled: Bool) {
        switch isEnabled {
        case false: self = .disabled
        case true: self = .enabled
        }
    }
}

// MARK: - Generic State Model (Enabled, Disabled)
/// Value group containing generic `enabled` and `disabled` values.
///
/// Used for mapping `GenericState_ED` to model.
public struct GenericStateModel_ED<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_ED` with values.
    public init(
        enabled: Value,
        disabled: Value
    ) {
        self.enabled = enabled
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_ED` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_ED` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_ED<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_ED` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_ED<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_ED {
    /// Initializes `GenericStateModel_ED` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_ED<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_ED {
    /// Initializes `GenericStateModel_ED` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_ED<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_ED {
    /// Initializes `GenericStateModel_ED` with `GenericStateModel_EPD`.
    public init(_ model: GenericStateModel_EPD<Value>) {
        self.init(
            enabled: model.enabled,
            disabled: model.disabled
        )
    }

    /// Initializes `GenericStateModel_ED` with `GenericStateModel_EFD`.
    public init(_ model: GenericStateModel_EFD<Value>) {
        self.init(
            enabled: model.enabled,
            disabled: model.disabled
        )
    }

    /// Initializes `GenericStateModel_ED` with `GenericStateModel_EPLD`.
    public init(_ model: GenericStateModel_EPLD<Value>) {
        self.init(
            enabled: model.enabled,
            disabled: model.disabled
        )
    }

    /// Initializes `GenericStateModel_ED` with `GenericStateModel_EPFD`.
    public init(_ model: GenericStateModel_EPFD<Value>) {
        self.init(
            enabled: model.enabled,
            disabled: model.disabled
        )
    }
}

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_ED: Hashable where Value: Hashable {}

extension GenericStateModel_ED: Equatable where Value: Equatable {}

extension GenericStateModel_ED: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.disabled)
    }
}

// MARK: - Mapping
extension GenericStateModel_ED {
    /// Maps `GenericState_ED` to `GenericStateModel_ED`.
    public func value(for state: GenericState_ED) -> Value {
        switch state {
        case .enabled: return enabled
        case .disabled: return disabled
        }
    }
}
