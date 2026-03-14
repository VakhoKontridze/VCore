//
//  ResponderChainUIToolbarAppearance.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.05.23.
//

#if canImport(UIKit) && !(os(tvOS) || os(watchOS) || os(visionOS))

import UIKit

/// Model that describes appearance.
public struct ResponderChainUIToolbarAppearance: Equatable {
    // MARK: Properties - Toolbar
    /// Toolbar style.
    public var style: UIBarStyle = .default

    /// Indicates if toolbar is translucent.
    public var isTranslucent: Bool = true

    /// Toolbar tint color.
    ///
    /// When value is `nil`, default color will be used.
    public var toolbarColor: UIColor?

    // MARK: Properties - Buttons
    var hasButtons: Bool { hasNavigationButtons || hasDoneButton }

    /// Button tint color.
    ///
    /// When value is `nil`, default color will be used.
    public var buttonColor: UIColor?

    // MARK: Properties - Buttons - Navigation
    /// Indicates if toolbar has navigation buttons.
    public var hasNavigationButtons: Bool = true

    // MARK: Properties - Buttons - Done
    /// Indicates if toolbar has done button.
    public var hasDoneButton: Bool = true

    // MARK: Initializers
    /// Initializes appearance with default values.
    public init() {}
}

#endif
