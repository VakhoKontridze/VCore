//
//  GenericStateModel_ED.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import Foundation

// MARK: - Generic State Model (Enabled, Disabled)
/// Value group containing generic `enabled` `disabled` values.
///
/// Group can be used to map model to viewmodel using a state represented by an enum.
///
///     typealias StateColors = GenericStateModel_EPD<UIColor?>
///
///     let titleColors: StateColors = .init(
///         enabled: .init(named: "TitleColor.enabled"),
///         disabled: .init(named: "TitleColor.disabled")
///     )
///
///     enum SomeState {
///         case enabled, disabled
///     }
///
///     extension StateColors {
///         func `for`(_ state: SomeState) -> Value {
///             switch state {
///             case .enabled: return enabled
///             case .disabled: return disabled
///             }
///         }
///     }
///
public struct GenericStateModel_ED<Value> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Value
    
    /// Disabled value.
    public var disabled: Value
    
    // MARK: Initializers
    /// Iniitalzies group with valus.
    public init(
        enabled: Value,
        disabled: Value
    ) {
        self.enabled = enabled
        self.disabled = disabled
    }
    
    /// Iniitalzies group with value.
    public init(
        _ value: Value
    ) {
        self.enabled = value
        self.disabled = value
    }
}

// MARK: - Hashable, Equatable, Comparable
extension GenericStateModel_ED: Hashable where Value: Hashable {}

extension GenericStateModel_ED: Equatable where Value: Equatable {}

extension GenericStateModel_ED: Comparable where Value: Comparable {
    public static func < (lhs: GenericStateModel_ED<Value>, rhs: GenericStateModel_ED<Value>) -> Bool {
        (lhs.enabled, lhs.disabled) < (rhs.enabled, rhs.disabled)
    }
}
