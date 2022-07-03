//
//  GenericState_EPF.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Genetic State (Enabled, Pressed, Focused)
/// Enumeration that represents state, such as `enabled`, `pressed`, or `focused`.
public enum GenericState_EPF: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    /// Focused.
    case focused
    
    // MARK: Initializers
    /// Initializes `GenericState_EPF` with flags.
    public init(isPressed: Bool, isFocused: Bool) {
        switch (isPressed, isFocused) {
        case (false, false): self = .enabled
        case (true, false): self = .pressed
        case (_, true): self = .focused
        }
    }
}

// MARK: - Generic State Model (Enabled, Pressed, Focused)
/// Value group containing generic `enabled`, `pressed`, and `focused` values.
///
/// Used for mapping `GenericState_EPF` to model.
public struct GenericStateModel_EPF<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Pressed value.
    public var pressed: Value
    
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
        self.pressed = pressed
        self.focused = focused
    }
    
    /// Initializes `GenericStateModel_EPF` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
        self.focused = value
    }
    
    /// Initializes `GenericStateModel_EPF` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EPF<CGFloat> {
        .init(0)
    }
    
    /// Initializes `GenericStateModel_EPF` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EPF<Color> {
        .init(.clear)
    }
}

// MARK: Platform-Specific Initializes
#if canImport(UIKit)

import UIKit

extension GenericStateModel_EPF {
    /// Initializes `GenericStateModel_EPF` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EPF<UIColor> {
        .init(.clear)
    }
}

#elseif canImport(AppKit)

import AppKit

extension GenericStateModel_EPF {
    /// Initializes `GenericStateModel_EPF` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EPF<NSColor> {
        .init(.clear)
    }
}

#endif

// MARK: Hashable, Equatable, Comparable
extension GenericStateModel_EPF: Hashable where Value: Hashable {}

extension GenericStateModel_EPF: Equatable where Value: Equatable {}

extension GenericStateModel_EPF: Comparable where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.enabled, \.pressed, \.focused)
    }
}

// MARK: - Mapping
extension GenericStateModel_EPF {
    /// Maps `GenericState_EPF` to `GenericStateModel_EPF`.
    public func value(for state: GenericState_EPF) -> Value {
        switch state {
        case .enabled: return enabled
        case .pressed: return pressed
        case .focused: return focused
        }
    }
}
