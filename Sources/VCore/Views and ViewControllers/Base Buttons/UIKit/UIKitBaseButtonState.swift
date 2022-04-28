//
//  BaseButtonState.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

import Foundation

// MARK: - UIKit Base Button State
/// Enum that describes state, such as `enabled` or `disabled`.
public enum UIKitBaseButtonState: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Disabled.
    case disabled
    
    // MARK: Initializers
    init(internalState: UIKitBaseButtonInternalState) {
        switch internalState {
        case .enabled: self = .enabled
        case .pressed: self = .enabled
        case .disabled: self = .disabled
        }
    }
}

// MARK: - UIKit Base Button Internal State
/// Enum that describes state, such as `enabled`, `pressed`, or `disabled`.
public enum UIKitBaseButtonInternalState: Int, CaseIterable {
    // MARK: Cases
    /// Enabled.
    case enabled
    
    /// Pressed.
    case pressed
    
    /// Disabled.
    case disabled
    
    // MARK: Properties
    var isEnabled: Bool {
        switch self {
        case .enabled: return true
        case .pressed: return true
        case .disabled: return false
        }
    }
    
    // MARK: Initializers
    init(isEnabled: Bool) {
        switch isEnabled {
        case false: self = .disabled
        case true: self = .enabled
        }
    }
    
    init(state: UIKitBaseButtonState, isPressed: Bool) {
        switch (state, isPressed) {
        case (.enabled, false): self = .enabled
        case (.enabled, true): self = .pressed
        case (.disabled, _): self = .disabled
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
    ///     titleLabel.textColor = titleColor.for(baseButton.internalButtonState)
    ///
    public func `for`(_ state: UIKitBaseButtonInternalState) -> Value {
        switch state {
        case .enabled: return enabled
        case .pressed: return pressed
        case .disabled: return disabled
        }
    }
}
