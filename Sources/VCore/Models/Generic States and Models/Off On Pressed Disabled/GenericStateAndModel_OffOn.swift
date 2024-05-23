//
//  GenericStateAndModel_OffOn.swift
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

// MARK: - Generic State (Off, On, Disabled)
/// Enumeration that represents state, such as `off` or `on`.
///
/// Used for mapping state to `GenericStateModel_OffOn`, with `value(for:)` method.
public enum GenericState_OffOn: Int, CaseIterable {
    // MARK: Cases
    /// Off.
    case off
    
    /// On.
    case on
    
    // MARK: Initializers
    /// Initializes `GenericState_OffOn` with flags.
    public init(isOn: Bool) {
        switch isOn {
        case false: self = .off
        case true: self = .on
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .off: self = .on
        case .on: self = .off
        }
    }
}

// MARK: - Binding Initializer
extension Binding where Value == GenericState_OffOn {
    /// Initializes `GenericState_OffOn` with `Bool`.
    public init(isOn: Binding<Bool>) {
        self.init(
            get: { GenericState_OffOn(isOn: isOn.wrappedValue) },
            set: { isOn.wrappedValue = $0 == .on }
        )
    }
}

// MARK: - Generic State Model (Off, On)
/// Value group containing `off` and `on`.
///
/// Used for mapping `GenericState_OffOn` to model, with `value(for:)` method.
@MemberwiseInitializable(
    accessLevelModifier: .public,
    comment: "/// Initializes `GenericStateModel_OffOn` with values."
)
public struct GenericStateModel_OffOn<Value> {
    // MARK: Properties
    /// Off value.
    public var off: Value
    
    /// On value.
    public var on: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_OffOn` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_OffOn` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OffOn<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_OffOn` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OffOn<Color> {
        .init(.clear)
    }

#if canImport(UIKit)
    
    /// Initializes `GenericStateModel_OffOn` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OffOn<UIColor> {
        .init(.clear)
    }
    
#elseif canImport(AppKit)
    
    /// Initializes `GenericStateModel_OffOn` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OffOn<NSColor> {
        .init(.clear)
    }
    
#endif
    
    // MARK: Initializers - Model Casting
    /// Initializes `GenericStateModel_OffOn` with `GenericStateModel_OffOnDisabled`.
    public init(_ model: GenericStateModel_OffOnDisabled<Value>) {
        self.init(
            off: model.off,
            on: model.on
        )
    }
    
    /// Initializes `GenericStateModel_OffOn` with `GenericStateModel_OffOnPressed`.
    public init(_ model: GenericStateModel_OffOnPressed<Value>) {
        self.init(
            off: model.off,
            on: model.on
        )
    }
    
    /// Initializes `GenericStateModel_OffOn` with `GenericStateModel_OffOnPressedDisabled`.
    public init(_ model: GenericStateModel_OffOnPressedDisabled<Value>) {
        self.init(
            off: model.off,
            on: model.on
        )
    }

    // MARK: Map
    /// Returns `GenericStateModel_OffOn`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            off: try transform(off),
            on: try transform(on)
        )
    }
}

// MARK: Equatable, Hashable
extension GenericStateModel_OffOn: Equatable where Value: Equatable {}

extension GenericStateModel_OffOn: Hashable where Value: Hashable {}

// MARK: - State-Model Mapping
extension GenericStateModel_OffOn {
    /// Maps `GenericState_OffOn` to `GenericStateModel_OffOn`.
    public func value(for state: GenericState_OffOn) -> Value {
        switch state {
        case .off: off
        case .on: on
        }
    }
}
