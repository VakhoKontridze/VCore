//
//  GenericState_EP.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Pressed)
/// Enumeration that represents state, such as `enabled` or `pressed`.
///
/// Used for mapping state to `GenericStateModel_EP`, via `value(for:)` method.
public enum GenericState_EP: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    // MARK: Initializers
    /// Initializes `GenericState_EP` with flag.
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
/// Used for mapping `GenericState_EP` to model, via `value(for:)` method.
public struct GenericStateModel_EP<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Pressed value.
    public var pressed: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EP` with values.
    public init(
        enabled: Value,
        pressed: Value
    ) {
        self.enabled = enabled
        self.pressed = pressed
    }
    
    /// Initializes `GenericStateModel_EP` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
    }
    
    /// Initializes `GenericStateModel_EP` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EP<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_EP` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EP<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_EP {
    /// Initializes `GenericStateModel_EP` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EP<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_EP {
    /// Initializes `GenericStateModel_EP` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EP<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_EP: Hashable where Value: Hashable {}

extension GenericStateModel_EP: Equatable where Value: Equatable {}

extension GenericStateModel_EP: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.pressed)
    }
}

// MARK: - Mapping
extension GenericStateModel_EP {
    /// Maps `GenericState_EP` to `GenericStateModel_EP`.
    public func value(for state: GenericState_EP) -> Value {
        switch state {
        case .enabled: return enabled
        case .pressed: return pressed
        }
    }
}
