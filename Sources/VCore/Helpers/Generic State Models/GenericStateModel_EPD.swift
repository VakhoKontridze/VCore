//
//  GenericStateModel_EPD.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import Foundation

// MARK: - Generic State Model (Enabled, Pressed, Disabled)
/// Value group containing generic `enabled`, `pressed`, and `disabled` values.
///
/// Group can be used to map model to viewmodel using a state represented by an enum.
///
///     typealias StateColors = GenericStateModel_EPD<UIColor?>
///
///     let titleColors: StateColors = .init(
///         enabled: .init(named: "TitleColor.enabled"),
///         pressed: .init(named: "TitleColor.pressed"),
///         disabled: .init(named: "TitleColor.disabled")
///     )
///
///     enum SomeState {
///         case enabled, pressed, disabled
///     }
///
///     extension StateColors {
///         func `for`(_ state: SomeState) -> Value {
///             switch state {
///             case .enabled: return enabled
///             case .pressed: return pressed
///             case .disabled: return disabled
///             }
///         }
///     }
///
public struct GenericStateModel_EPD<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Pressed value.
    public var pressed: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Iniitalzies group with valus.
    public init(
        enabled: Value,
        pressed: Value,
        disabled: Value
    ) {
        self.enabled = enabled
        self.pressed = pressed
        self.disabled = disabled
    }
    
    /// Iniitalzies group with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.pressed = value
        self.disabled = value
    }
}

// MARK: - Hashable, Equatable, Comparable
extension GenericStateModel_EPD: Hashable where Value: Hashable {}

extension GenericStateModel_EPD: Equatable where Value: Equatable {}

extension GenericStateModel_EPD: Comparable where Value: Comparable {
    public static func < (lhs: GenericStateModel_EPD<Value>, rhs: GenericStateModel_EPD<Value>) -> Bool {
        (lhs.enabled, lhs.pressed, lhs.disabled) < (rhs.enabled, rhs.pressed, rhs.disabled)
    }
}
