//
//  SwiftUIResponderChainToolBarUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.05.23.
//

import SwiftUI

// MARK: - Responder Chain Tool Bar UI Model (SwiftUI)
/// Model that describes UI.
public struct SwiftUIResponderChainToolBarUIModel {
    // MARK: Properties - Buttons
    var hasButtons: Bool { hasNavigationButtons || hasDoneButton }

    /// Button colors.
    public var buttonColors: ButtonStateColors = .init(
        enabled: .accentColor,
        disabled: Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.3)
    )

    // MARK: Properties - Buttons - Navigation
    /// Indicates if toolbar has navigation buttons. Set to `true`.
    public var hasNavigationButtons: Bool = true

    // MARK: Properties - Buttons - Done
    /// Indicates if toolbar has done button. Set to `true`.
    public var hasDoneButton: Bool = true

    /// Done button font. Set to `semibold` `body`.
    public var doneButtonFont: Font = .body.weight(.semibold)

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}

    // MARK: Button State Colors
    /// Model that contains colors for button states.
    public typealias ButtonStateColors = GenericStateModel_EnabledDisabled<Color>
}
