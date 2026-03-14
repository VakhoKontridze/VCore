//
//  ResponderChainToolbarAppearance.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.05.23.
//

import SwiftUI

/// Model that describes appearance.
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
public struct ResponderChainToolbarAppearance: Equatable {
    // MARK: Properties - Buttons
    var hasButtons: Bool { hasNavigationButtons || hasDoneButton }

    /// Button colors.
    public var buttonColors: ButtonStateColors = .init(
        enabled: Color.accentColor,
        disabled: Color.gray.opacity(0.3)
    )

    // MARK: Properties - Buttons - Navigation
    /// Indicates if toolbar has navigation buttons.
    public var hasNavigationButtons: Bool = true

    // MARK: Properties - Buttons - Done
    /// Indicates if toolbar has done button.
    public var hasDoneButton: Bool = true

    /// Done button font.
    public var doneButtonFont: Font = .body.weight(.semibold)

    // MARK: Initializers
    /// Initializes appearance with default values.
    public init() {}

    // MARK: Types
    /// State-bound colors.
    public typealias ButtonStateColors = GenericStateModel_EnabledDisabled<Color>
}
