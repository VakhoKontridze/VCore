//
//  GenericStateAndModel_EFD.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 3/10/22.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Focused, Disabled)
/// Enumeration that represents state, such as `enabled`, `focused`, or `disabled`.
///
/// Used for mapping state to `GenericStateModel_EFD`, via `value(for:)` method.
public enum GenericState_EFD: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Focused.
    case focused
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if interaction is enabled.
    public var isEnabled: Bool {
        switch self {
        case .enabled: return true
        case .focused: return true
        case .disabled: return false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_EFD` with flags.
    public init(isEnabled: Bool, isFocused: Bool) {
        switch (isEnabled, isFocused) {
        case (false, _): self = .disabled
        case (true, false): self = .enabled
        case (true, true): self = .focused
        }
    }
}

// MARK: - Generic State Model (Enabled, Focused, Disabled)
/// Value group containing generic `enabled`, `focused`, and `disabled` values.
///
/// Used for mapping `GenericState_EFD` to model, via `value(for:)` method.
public struct GenericStateModel_EFD<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Focused value.
    public var focused: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EFD` with values.
    public init(
        enabled: Value,
        focused: Value,
        disabled: Value
    ) {
        self.enabled = enabled
        self.focused = focused
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_EFD` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.focused = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_EFD` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EFD<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_EFD` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EFD<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_EFD {
    /// Initializes `GenericStateModel_EFD` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EFD<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_EFD {
    /// Initializes `GenericStateModel_EFD` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EFD<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Model-Casting Initializers
extension GenericStateModel_EFD {
    /// Initializes `GenericStateModel_EFD` with `GenericStateModel_EPFD`.
    public init(_ model: GenericStateModel_EPFD<Value>) {
        self.init(
            enabled: model.enabled,
            focused: model.focused,
            disabled: model.disabled
        )
    }
}

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_EFD: Hashable where Value: Hashable {}

extension GenericStateModel_EFD: Equatable where Value: Equatable {}

extension GenericStateModel_EFD: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.focused, \.disabled)
    }
}

// MARK: - Mapping
extension GenericStateModel_EFD {
    /// Maps `GenericState_EFD` to `GenericStateModel_EFD`.
    public func value(for state: GenericState_EFD) -> Value {
        switch state {
        case .enabled: return enabled
        case .focused: return focused
        case .disabled: return disabled
        }
    }
}
