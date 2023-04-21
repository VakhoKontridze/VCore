//
//  GenericState_EnabledPressed.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Pressed)
/// Enumeration that represents state, such as `enabled` or `pressed`.
///
/// Used for mapping state to `GenericStateModel_EnabledPressed`, via `value(for:)` method.
public enum GenericState_EnabledPressed: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    // MARK: Initializers
    /// Initializes `GenericState_EnabledPressed` with flag.
    public init(isPressed: Bool) {
        switch isPressed {
        case false: self = .enabled
        case true: self = .pressed
        }
    }
}

// MARK: - Generic State Model (Enabled, Pressed)
/// Value group containing generic `enabled` and `pressed` values.
///
/// Used for mapping `GenericState_EnabledPressed` to model, via `value(for:)` method.
public struct GenericStateModel_EnabledPressed<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Pressed value.
    public var pressed: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EnabledPressed` with values.
    public init(
        enabled: Value,
        pressed: Value
    ) {
        self.enabled = enabled
        self.pressed = pressed
    }
    
    /// Initializes `GenericStateModel_EnabledPressed` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
    }
    
    /// Initializes `GenericStateModel_EnabledPressed` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledPressed<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_EnabledPressed` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledPressed<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_EnabledPressed {
    /// Initializes `GenericStateModel_EnabledPressed` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledPressed<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_EnabledPressed {
    /// Initializes `GenericStateModel_EnabledPressed` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledPressed<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Equatable, Hashable, Comparable
extension GenericStateModel_EnabledPressed: Equatable where Value: Equatable {}

extension GenericStateModel_EnabledPressed: Hashable where Value: Hashable {}

extension GenericStateModel_EnabledPressed: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.pressed)
    }
}

// MARK: - Mapping
extension GenericStateModel_EnabledPressed {
    /// Maps `GenericState_EnabledPressed` to `GenericStateModel_EnabledPressed`.
    public func value(for state: GenericState_EnabledPressed) -> Value {
        switch state {
        case .enabled: return enabled
        case .pressed: return pressed
        }
    }
}
