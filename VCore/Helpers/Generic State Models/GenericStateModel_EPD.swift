//
//  GenericStateModel_EPD.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import Foundation

// MARK: - Generic State Model (Enabled, Pressed, Disabled)
/// Property group containing generic `enabled`, `pressed`, and `disabled` values.
///
/// Group can be used to map model to viewmodel using a state represented by an enum.
///
/// Usage example:
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
///         func `for`(_ state: SomeState) -> Property {
///             switch state {
///             case .enabled: return enabled
///             case .pressed: return pressed
///             case .disabled: return disabled
///             }
///         }
///     }
///
public struct GenericStateModel_EPD<Property> {
    // MARK: Properties
    /// Enabled value.
    public var enabled: Property
    
    /// Pressed value.
    public var pressed: Property
    
    /// Disabled value.
    public var disabled: Property
    
    // MARK: Initializers
    /// Iniitalzies group with valus.
    public init(
        enabled: Property,
        pressed: Property,
        disabled: Property
    ) {
        self.enabled = enabled
        self.pressed = pressed
        self.disabled = disabled
    }
    
    /// Iniitalzies group with value.
    public init(
        _ property: Property
    ) {
        self.enabled = property
        self.pressed = property
        self.disabled = property
    }
}
