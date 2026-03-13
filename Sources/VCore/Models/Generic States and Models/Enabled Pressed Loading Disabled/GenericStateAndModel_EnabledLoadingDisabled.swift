//
//  GenericStateAndModel_EnabledLoadingDisabled.swift
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
public enum GenericState_EnabledLoadingDisabled: Int, Sendable, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Loading.
    case loading
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    /// Indicates if gesture is enabled.
    public var isGestureEnabled: Bool {
        switch self {
        case .enabled: true
        case .loading: false
        case .disabled: false
        }
    }
    
    // MARK: Initializers
    /// Initializes `GenericState_EnabledLoadingDisabled` with flags.
    public init(isEnabled: Bool, isLoading: Bool) {
        switch (isEnabled, isLoading) {
        case (false, _): self = .disabled
        case (true, false): self = .enabled
        case (true, true): self = .loading
        }
    }
}

/// Model containing generic state-bound values.
@MemberwiseInitializable(
    comment: "/// Initializes `GenericStateModel_EnabledLoadingDisabled` with values."
)
public struct GenericStateModel_EnabledLoadingDisabled<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Loading value.
    public var loading: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Initializes `GenericStateModel_EnabledLoadingDisabled` with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.loading = value
        self.disabled = value
    }
    
    // MARK: Initializers - Dimensions
    /// Initializes `GenericStateModel_EnabledLoadingDisabled` with `0` `CGFloat` values.
    public static var zero: GenericStateModel_EnabledLoadingDisabled<CGFloat> {
        .init(0)
    }
    
    // MARK: Initializers - Colors
    /// Initializes `GenericStateModel_EnabledLoadingDisabled` with `clear` `Color` values.
    public static var clearColors: GenericStateModel_EnabledLoadingDisabled<Color> {
        .init(.clear)
    }

#if canImport(UIKit)

    /// Initializes `GenericStateModel_EnabledLoadingDisabled` with `clear` `UIColor` values.
    public static var clearUIColors: GenericStateModel_EnabledLoadingDisabled<UIColor> {
        .init(.clear)
    }

#elseif canImport(AppKit)

    /// Initializes `GenericStateModel_EnabledLoadingDisabled` with `clear` `NSColor` values.
    public static var clearNSColors: GenericStateModel_EnabledLoadingDisabled<NSColor> {
        .init(.clear)
    }

#endif

    // MARK: Initializers - Model Casting
    /// Initializes `GenericStateModel_EnabledLoadingDisabled` with `GenericStateModel_EnabledPressedLoadingDisabled`.
    public init(_ model: GenericStateModel_EnabledPressedLoadingDisabled<Value>) {
        self.init(
            enabled: model.enabled,
            loading: model.loading,
            disabled: model.disabled
        )
    }

    // MARK: Map
    /// Returns `GenericStateModel_EnabledLoadingDisabled`  containing the results of mapping the given closure over the values.
    public func map<NewValue>(
        _ transform: (Value) throws -> NewValue
    ) rethrows -> GenericStateModel_EnabledLoadingDisabled<NewValue> {
        .init(
            enabled: try transform(enabled),
            loading: try transform(loading),
            disabled: try transform(disabled)
        )
    }
}

extension GenericStateModel_EnabledLoadingDisabled: Equatable where Value: Equatable {}

extension GenericStateModel_EnabledLoadingDisabled: Hashable where Value: Hashable {}

extension GenericStateModel_EnabledLoadingDisabled: Sendable where Value: Sendable {}

extension GenericStateModel_EnabledLoadingDisabled {
    /// Maps state to model.
    public func value(for state: GenericState_EnabledLoadingDisabled) -> Value {
        switch state {
        case .enabled: enabled
        case .loading: loading
        case .disabled: disabled
        }
    }
}
