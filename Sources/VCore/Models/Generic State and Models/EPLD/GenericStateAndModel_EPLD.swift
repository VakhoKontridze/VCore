//
//  GenericStateAndModel_EPLD.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 3/10/22.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Pressed, Loading, Disabled)
/// Enumeration that represents state, such as `enabled`, `pressed`, `loading`, or `disabled`.
public enum GenericState_EPLD: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    /// Loading.
    case loading
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if interaction is enabled.
    public var isEnabled: Bool {
        switch self {
        case .enabled: return true
        case .pressed: return true
        case .loading: return false
        case .disabled: return false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_EPLD` with flags.
    public init(isEnabled: Bool, isPressed: Bool, isLoading: Bool) {
        switch (isEnabled, isPressed, isLoading) {
        case (false, _, _): self = .disabled
        case (true, false, false): self = .enabled
        case (true, true, false): self = .pressed
        case (true, _, true): self = .loading
        }
    }
}

// MARK: - Generic State Model (Enabled, Pressed, Loading, Disabled)
/// Value group containing generic `enabled`, `pressed`, `loading`, and `disabled` values.
///
/// Used for mapping `GenericState_EPLD` to model.
public struct GenericStateModel_EPLD<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Pressed value.
    public var pressed: Value
    
    /// Loading value.
    public var loading: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EPLD` with values.
    public init(
        enabled: Value,
        pressed: Value,
        loading: Value,
        disabled: Value
    ) {
        self.enabled = enabled
        self.pressed = pressed
        self.loading = loading
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_EPLD` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
        self.loading = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_EPLD` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EPLD<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_EPLD` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EPLD<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_EPLD {
    /// Initializes `GenericStateModel_EPLD` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EPLD<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_EPLD {
    /// Initializes `GenericStateModel_EPLD` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EPLD<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_EPLD: Hashable where Value: Hashable {}

extension GenericStateModel_EPLD: Equatable where Value: Equatable {}

extension GenericStateModel_EPLD: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.pressed, \.loading, \.disabled)
    }
}

// MARK: - Mapping
extension GenericStateModel_EPLD {
    /// Maps `GenericState_EPLD` to `GenericStateModel_EPLD`.
    public func value(for state: GenericState_EPLD) -> Value {
        switch state {
        case .enabled: return enabled
        case .pressed: return pressed
        case .loading: return loading
        case .disabled: return disabled
        }
    }
}
