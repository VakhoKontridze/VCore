//
//  GenericStateAndModel_OffOnIndeterminatePressedDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 3/1/22.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Enumeration that represents state.
public nonisolated enum GenericState_OffOnIndeterminatePressedDisabled: Int, Sendable, CaseIterable {
    // MARK: Cases
    /// Off.
    case off
    
    /// On.
    case on
    
    /// Indeterminate.
    case indeterminate
    
    /// Pressed (off).
    case pressedOff
    
    /// Pressed (on).
    case pressedOn
    
    /// Pressed (indeterminate).
    case pressedIndeterminate
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if gesture is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .off: true
        case .on: true
        case .indeterminate: true
        case .pressedOff: true
        case .pressedOn: true
        case .pressedIndeterminate: true
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_OffOnPressedDisabled` with flags.
    public init(isEnabled: Bool, state: GenericState_OffOnIndeterminate, isPressed: Bool) {
        switch (isEnabled, state, isPressed) {
        case (false, _, _): self = .disabled
        case (true, .off, false): self = .off
        case (true, .off, true): self = .pressedOff
        case (true, .on, false): self = .on
        case (true, .on, true): self = .pressedOn
        case (true, .indeterminate, false): self = .indeterminate
        case (true, .indeterminate, true): self = .pressedIndeterminate
        }
    }
    
    // MARK: Next State
    /// Goes to the next state.
    mutating public func setNextState() {
        switch self {
        case .off, .pressedOff: self = .on
        case .on, .pressedOn: self = .off
        case .indeterminate, .pressedIndeterminate: self = .on
        case .disabled: break
        }
    }
}

/// Model containing generic state-bound values.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_OffOnIndeterminatePressedDisabled` with values."
)
public nonisolated struct GenericStateModel_OffOnIndeterminatePressedDisabled<Value> {
    // MARK: Properties
    /// Off value.
    public var off: Value
    
    /// On value.
    public var on: Value
    
    /// Indeterminate value.
    public var indeterminate: Value
    
    /// Pressed (off) value.
    public var pressedOff: Value
    
    /// Pressed (on) value.
    public var pressedOn: Value
    
    /// Pressed (indeterminate) value.
    public var pressedIndeterminate: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_OffOnIndeterminatePressedDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.off = value
        self.on = value
        self.indeterminate = value
        self.pressedOff = value
        self.pressedOn = value
        self.pressedIndeterminate = value
        self.disabled = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_OffOnIndeterminatePressedDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_OffOnIndeterminatePressedDisabled<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_OffOnIndeterminatePressedDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_OffOnIndeterminatePressedDisabled<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_OffOnIndeterminatePressedDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_OffOnIndeterminatePressedDisabled<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_OffOnIndeterminatePressedDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_OffOnIndeterminatePressedDisabled<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Map
    /// Returns `GenericStateModel_OffOnIndeterminatePressedDisabled`  containing the results of mapping the given closure over the values.
    public func map<NewValue>(
        _ transform: (Value) throws -> NewValue
    ) rethrows -> GenericStateModel_OffOnIndeterminatePressedDisabled<NewValue> {
        .init(
            off: try transform(off),
            on: try transform(on),
            indeterminate: try transform(indeterminate),
            pressedOff: try transform(pressedOff),
            pressedOn: try transform(pressedOn),
            pressedIndeterminate: try transform(pressedIndeterminate),
            disabled: try transform(disabled)
        )
    }
}

nonisolated extension GenericStateModel_OffOnIndeterminatePressedDisabled: Equatable where Value: Equatable {}

nonisolated extension GenericStateModel_OffOnIndeterminatePressedDisabled: Hashable where Value: Hashable {}

nonisolated extension GenericStateModel_OffOnIndeterminatePressedDisabled: Sendable where Value: Sendable {}

nonisolated extension GenericStateModel_OffOnIndeterminatePressedDisabled {
    /// Maps state to model.
    public func value(for state: GenericState_OffOnIndeterminatePressedDisabled) -> Value {
        switch state {
        case .off: off
        case .on: on
        case .indeterminate: indeterminate
        case .pressedOff: pressedOff
        case .pressedOn: pressedOn
        case .pressedIndeterminate: pressedIndeterminate
        case .disabled: disabled
        }
    }
}
