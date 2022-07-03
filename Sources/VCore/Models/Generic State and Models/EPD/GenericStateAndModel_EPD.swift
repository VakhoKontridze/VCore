//
//  GenericStateAndModel_EPD.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Pressed, Disabled)
/// Enumeration that represents state, such as `enabled`, `pressed`, or `disabled`.
///
/// Used for mapping state to `GenericStateModel_EPD`, via `value(for:)` method.
public enum GenericState_EPD: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if interaction is enabled.
    public var isEnabled: Bool {
        switch self {
        case .enabled: return true
        case .pressed: return true
        case .disabled: return false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_EPD` with flags.
    public init(isEnabled: Bool, isPressed: Bool) {
        switch (isEnabled, isPressed) {
        case (false, _): self = .disabled
        case (true, false): self = .enabled
        case (true, true): self = .pressed
        }
    }
}

// MARK: - Generic State Model (Enabled, Pressed, Disabled)
/// Value group containing generic `enabled`, `pressed`, and `disabled` values.
///
/// Used for mapping `GenericState_EPD` to model, via `value(for:)` method.
public struct GenericStateModel_EPD<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Pressed value.
    public var pressed: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EPD` with values.
    public init(
        enabled: Value,
        pressed: Value,
        disabled: Value
    ) {
        self.enabled = enabled
        self.pressed = pressed
        self.disabled = disabled
    }
    
    /// Initializes `GenericStateModel_EPD` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
        self.disabled = value
    }
    
    /// Initializes `GenericStateModel_EPD` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EPD<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_EPD` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EPD<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_EPD {
    /// Initializes `GenericStateModel_EPD` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EP<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_EPD {
    /// Initializes `GenericStateModel_EPD` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EP<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_EPD: Hashable where Value: Hashable {}

extension GenericStateModel_EPD: Equatable where Value: Equatable {}

extension GenericStateModel_EPD: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.pressed, \.disabled)
    }
}

// MARK: - Mapping
extension GenericStateModel_EPD {
    /// Maps `GenericState_EPD` to `GenericStateModel_EPD`.
    public func value(for state: GenericState_EPD) -> Value {
        switch state {
        case .enabled: return enabled
        case .pressed: return pressed
        case .disabled: return disabled
        }
    }
}
