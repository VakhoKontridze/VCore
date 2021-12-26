//
//  BaseButtonState.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

import Foundation

// MARK: - UIKit Base Button State
/// Enum that describes state, such as `enabled`, `pressed`, or `disabled`.
public enum UIKitBaseButtonState: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    /// Disabled.
    case disabled
    
    // MARK: Initializers
    init(_ isUserInteractionEnabled: Bool) {
        switch isUserInteractionEnabled {
        case false: self = .disabled
        case true: self = .enabled
        }
    }
    
    init(isPressed: Bool) {
        switch isPressed {
        case false: self = .enabled
        case true: self = .pressed
        }
    }
    
    /// Default value for `UIKitBaseButtonInternalState`.
    public static var `default`: Self { .enabled }
}

// MARK: - Mapping
extension GenericStateModel_EPD {
    /// Allows for dynamic mapping between `Model` and `State`.
    ///
    /// Usage Example:
    ///
    ///     let baseButton: UIKitBaseButton = {
    ///         // ...
    ///     }()
    ///
    ///     let titleLabel: UILabel = {
    ///         // ...
    ///     }()
    ///
    ///     let titleColor: GenericStateModel_EPD<UIColor?> = .init(
    ///         enabled: .black,
    ///         pressed: .gray,
    ///         disabled: .gray
    ///     )
    ///
    ///     titleLabel.textColor = titleColor.for(baseButton.buttonState)
    ///
    public func `for`(_ state: UIKitBaseButtonState) -> Value {
        switch state {
        case .enabled: return enabled
        case .pressed: return pressed
        case .disabled: return disabled
        }
    }
}
