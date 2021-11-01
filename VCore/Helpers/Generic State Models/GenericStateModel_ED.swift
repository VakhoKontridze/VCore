//
//  GenericStateModel_ED.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import UIKit

// MARK: - Generic State Model (Enabled, Disabled)
/// Property group containing generic `enabled` `disabled` values.
///
/// Group can be used to map model to viewmodel using a state represented by an enum.
///
/// Usage example:
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
///         func `for`(_ state: SomeState) -> Property {
///             switch state {
///             case .enabled: return enabled
///             case .disabled: return disabled
///             }
///         }
///     }
///
public struct GenericStateModel_ED<Property> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Property
    
    /// Disabled value.
    public var disabled: Property
    
    // MARK: Initializers
    /// Iniitalzies group with valus.
    public init(
        enabled: Property,
        disabled: Property
    ) {
        self.enabled = enabled
        self.disabled = disabled
    }
    
    /// Iniitalzies group with value.
    public init(
        _ property: Property
    ) {
        self.init(
            enabled: property,
            disabled: property
        )
    }
}
