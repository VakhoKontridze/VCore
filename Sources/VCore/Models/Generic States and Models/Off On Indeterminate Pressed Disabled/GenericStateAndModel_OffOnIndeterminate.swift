//
//  GenericStateAndModel_OffOnIndeterminate.swift
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

/// Enumeration that represents state.
public enum GenericState_OffOnIndeterminate: Int, Sendable, CaseIterable {
    // MARK: Cases
    /// Off.
    case off
    
    /// On.
    case on
    
    /// Indeterminate.
    case indeterminate
    
    // MARK: Initializers
    /// Initializes `GenericState_OOI` with flags.
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
        case .indeterminate: self = .on
        }
    }
}

extension Binding where Value == GenericState_OffOnIndeterminate {
    /// Initializes `GenericState_OOI` with `Bool`.
    public init(isOn: Binding<Bool>) {
        self.init(
            get: { GenericState_OffOnIndeterminate(isOn: isOn.wrappedValue) },
            set: { isOn.wrappedValue = $0 == .on }
        )
    }
}

/// Group containing generic state-bound values.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_OffOnIndeterminate` with values."
)
public struct GenericStateModel_OffOnIndeterminate<Value> {
    // MARK: Properties
    /// Off value.
    public var off: Value
    
    /// On value.
    public var on: Value
    
    /// Indeterminate value.
    public var indeterminate: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_OffOnIndeterminate` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
        self.indeterminate = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_OffOnIndeterminate` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OffOnIndeterminate<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_OffOnIndeterminate` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OffOnIndeterminate<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_OffOnIndeterminate` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OffOnIndeterminate<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_OffOnIndeterminate` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OffOnIndeterminate<NSColor> {
        .init(.clear)
    }
    
#endif

    // MARK: Initializers - Model Casting
    /// Initializes `GenericStateModel_OffOnIndeterminate` with `GenericStateModel_OffOnIndeterminateDisabled`.
    public init(_ model: GenericStateModel_OffOnIndeterminateDisabled<Value>) {
        self.init(
            off: model.off,
            on: model.on,
            indeterminate: model.indeterminate
        )
    }

    /// Initializes `GenericStateModel_OffOnIndeterminate` with `GenericStateModel_OffOnIndeterminatePressed`.
    public init(_ model: GenericStateModel_OffOnIndeterminatePressed<Value>) {
        self.init(
            off: model.off,
            on: model.on,
            indeterminate: model.indeterminate
        )
    }

    /// Initializes `GenericStateModel_OffOnIndeterminate` with `GenericStateModel_OffOnIndeterminatePressedDisabled`.
    public init(_ model: GenericStateModel_OffOnIndeterminatePressedDisabled<Value>) {
        self.init(
            off: model.off,
            on: model.on,
            indeterminate: model.indeterminate
        )
    }

    // MARK: Map
    /// Returns `GenericStateModel_OffOnIndeterminate`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (Value) throws -> Value
    ) rethrows -> Self {
        .init(
            off: try transform(off),
            on: try transform(on),
            indeterminate: try transform(indeterminate)
        )
    }
}

extension GenericStateModel_OffOnIndeterminate: Equatable where Value: Equatable {}

extension GenericStateModel_OffOnIndeterminate: Hashable where Value: Hashable {}

extension GenericStateModel_OffOnIndeterminate: Sendable where Value: Sendable {}

extension GenericStateModel_OffOnIndeterminate {
    /// Maps state to model.
    public func value(for state: GenericState_OffOnIndeterminate) -> Value {
        switch state {
        case .off: off
        case .on: on
        case .indeterminate: indeterminate
        }
    }
}
