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
    // MARK: Properties
    /// Model that contains layout properties.
    public var layout: Layout = .init()

    /// Model that contains color properties.
    public var colors: Colors = .init()

    /// Model that contains font properties.
    public var fonts: Fonts = .init()

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}

    // MARK: Layout
    /// Model that contains layout properties.
    public struct Layout {
        // MARK: Properties
        /// Indicates if toolbar has navigation buttons. Set to `true`.
        public var hasNavigationButtons: Bool = true

        /// Indicates if toolbar has done button. Set to `true`.
        public var hasDoneButton: Bool = true

        var hasButtons: Bool { hasNavigationButtons || hasDoneButton }

        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }

    // MARK: Colors
    /// Model that contains color properties.
    public struct Colors {
        // MARK: Properties
        /// Button colors.
        public var button: ButtonStateColors = .init(
            enabled: .accentColor,
            disabled: Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.3)
        )

        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}

        // MARK: Button State Colors
        /// Model that contains colors for button states.
        public typealias ButtonStateColors = GenericStateModel_EnabledDisabled<Color>
    }

    // MARK: Fonts
    /// Model that contains font properties.
    public struct Fonts {
        // MARK: Properties
        /// Done button font. Set to `semibold` `body`.
        public var doneButton: Font = .body.weight(.semibold)

        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }
}
