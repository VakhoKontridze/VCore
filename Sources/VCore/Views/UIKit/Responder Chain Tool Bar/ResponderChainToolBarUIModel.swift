//
//  ResponderChainToolBarUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.05.23.
//

#if os(iOS) || targetEnvironment(macCatalyst)

import UIKit

// MARK: - Responder Chain Tool Bar UI Model
/// Model that describes UI.
public struct ResponderChainToolBarUIModel {
    // MARK: Properties
    /// Model that contains layout properties.
    public var layout: Layout = .init()

    /// Model that contains color properties.
    public var colors: Colors = .init()

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
        /// Toolbar style. Set to `default`.
        public var style: UIBarStyle = .default

        /// Indicates if toolbar is translucent. Set to `true`.
        public var isTranslucent: Bool = true

        /// Toolbar tint color. Set to `nil`.
        ///
        /// When value is `nil`, default color will be used.
        public var toolbar: UIColor?

        /// Button tint color. Set to `nil`.
        ///
        /// When value is `nil`, default color will be used.
        public var button: UIColor?

        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }
}

#endif
