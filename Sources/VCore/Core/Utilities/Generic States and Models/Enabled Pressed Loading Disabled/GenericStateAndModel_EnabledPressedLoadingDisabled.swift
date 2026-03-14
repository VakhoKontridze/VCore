//
//  GenericStateAndModel_EnabledPressedLoadingDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 3/10/22.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Enumeration that represents state.
public nonisolated enum GenericState_EnabledPressedLoadingDisabled: Int, Sendable, CaseIterable {
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
    /// Indicates if gesture is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .enabled: true
        case .pressed: true
        case .loading: false
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_EnabledPressedLoadingDisabled` with flags.
    public init(isEnabled: Bool, isPressed: Bool, isLoading: Bool) {
        switch (isEnabled, isPressed, isLoading) {
        case (false, _, _): self = .disabled
        case (true, false, false): self = .enabled
        case (true, true, false): self = .pressed
        case (true, _, true): self = .loading
        }
    }
}

/// Model containing generic state-bound values.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_EnabledPressedLoadingDisabled` with values."
)
public nonisolated struct GenericStateModel_EnabledPressedLoadingDisabled<Value> {
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
    /// Initializes `GenericStateModel_EnabledPressedLoadingDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
        self.loading = value
        self.disabled = value
    }

    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_EnabledPressedLoadingDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledPressedLoadingDisabled<CGFloat> {
        .init(0)
    }

    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_EnabledPressedLoadingDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledPressedLoadingDisabled<Color> {
        .init(.clear)
    }
    
#if canImport(UIKit)
    
    /// Initializes `GenericStateModel_EnabledPressedLoadingDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledPressedLoadingDisabled<UIColor> {
        .init(.clear)
    }
    
#elseif canImport(AppKit)
    
    /// Initializes `GenericStateModel_EnabledPressedLoadingDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledPressedLoadingDisabled<NSColor> {
        .init(.clear)
    }
    
#endif

    // MARK: Map
    /// Returns `GenericStateModel_EnabledPressedLoadingDisabled`  containing the results of mapping the given closure over the values.
    public func map<NewValue>(
        _ transform: (Value) throws -> NewValue
    ) rethrows -> GenericStateModel_EnabledPressedLoadingDisabled<NewValue> {
        .init(
            enabled: try transform(enabled),
            pressed: try transform(pressed),
            loading: try transform(loading),
            disabled: try transform(disabled)
        )
    }
}

nonisolated extension GenericStateModel_EnabledPressedLoadingDisabled: Equatable where Value: Equatable {}

nonisolated extension GenericStateModel_EnabledPressedLoadingDisabled: Hashable where Value: Hashable {}

nonisolated extension GenericStateModel_EnabledPressedLoadingDisabled: Sendable where Value: Sendable {}

nonisolated extension GenericStateModel_EnabledPressedLoadingDisabled {
    /// Maps state to model.
    public func value(for state: GenericState_EnabledPressedLoadingDisabled) -> Value {
        switch state {
        case .enabled: enabled
        case .pressed: pressed
        case .loading: loading
        case .disabled: disabled
        }
    }
}
