//
//  GenericState_OffOnIndeterminateDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Generic State (Off, On, Indeterminate, Disabled)
/// Enumeration that represents state.
///
/// Used for mapping state to `GenericStateModel_OffOnIndeterminateDisabled`, with `value(for:)` method.
public enum GenericState_OffOnIndeterminateDisabled: Int, Sendable, CaseIterable {
    // MARK: Cases
    /// Off.
    case off
    
    /// On.
    case on
    
    /// Indeterminate.
    case indeterminate
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if gesture is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .off: true
        case .on: true
        case .indeterminate: true
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_OffOnPressedDisabled` with flags.
    public init(isEnabled: Bool, state: GenericState_OffOnIndeterminate) {
        switch (isEnabled, state) {
        case (false, _): self = .disabled
        case (true, .off): self = .off
        case (true, .on): self = .on
        case (true, .indeterminate): self = .indeterminate
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .off: self = .on
        case .on: self = .off
        case .indeterminate: self = .on
        case .disabled: break
        }
    }
}

// MARK: - Generic State Model (Off, On, Indeterminate, Disabled)
/// Value group containing `off`, `on`, `indeterminate`, and `disabled`.
///
/// Used for mapping `GenericState_OffOnIndeterminateDisabled` to model, with `value(for:)` method.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_OffOnIndeterminateDisabled` with values."
)
public struct GenericStateModel_OffOnIndeterminateDisabled<Value> {
    // MARK: Properties
    /// Off value.
    public var off: Value
    
    /// On value.
    public var on: Value
    
    /// Indeterminate value.
    public var indeterminate: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_OffOnIndeterminateDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
        self.indeterminate = value
        self.disabled = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_OffOnIndeterminateDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OffOnIndeterminateDisabled<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_OffOnIndeterminateDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OffOnIndeterminateDisabled<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_OffOnIndeterminateDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OffOnIndeterminateDisabled<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_OffOnIndeterminateDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OffOnIndeterminateDisabled<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Initializers - Model Casting
    /// Initializes `GenericStateModel_OffOnIndeterminateDisabled` with `GenericStateModel_OffOnIndeterminatePressedDisabled`.
    public init(_ model: GenericStateModel_OffOnIndeterminatePressedDisabled<Value>) {
        self.init(
            off: model.off,
            on: model.on,
            indeterminate: model.indeterminate,
            disabled: model.disabled
        )
    }

    // MARK: Map
    /// Returns `GenericStateModel_OffOnIndeterminateDisabled`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            off: try transform(off),
            on: try transform(on),
            indeterminate: try transform(indeterminate),
            disabled: try transform(disabled)
        )
    }
}

// MARK: Equatable, Hashable
extension GenericStateModel_OffOnIndeterminateDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_OffOnIndeterminateDisabled: Hashable where Value: Hashable {}

// MARK: Sendable
extension GenericStateModel_OffOnIndeterminateDisabled: Sendable where Value: Sendable {}

// MARK: - State-Model Mapping
extension GenericStateModel_OffOnIndeterminateDisabled {
    public func value(for state: GenericState_OffOnIndeterminateDisabled) -> Value {
        switch state {
        case .off: off
        case .on: on
        case .indeterminate: indeterminate
        case .disabled: disabled
        }
    }
}
