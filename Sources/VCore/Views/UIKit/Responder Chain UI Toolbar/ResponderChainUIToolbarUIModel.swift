//
//  ResponderChainUIToolbarUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.05.23.
//

#if canImport(UIKit) && !(os(tvOS) || os(watchOS) || os(visionOS))

import UIKit

// MARK: - Responder Chain UI Toolbar UI Model
/// Model that describes UI.
public struct ResponderChainUIToolbarUIModel {
    // MARK: Properties - Toolbar
    /// Toolbar style. Set to `default`.
    public var style: UIBarStyle = .default

    /// Indicates if toolbar is translucent. Set to `true`.
    public var isTranslucent: Bool = true

    /// Toolbar tint color. Set to `nil`.
    ///
    /// When value is `nil`, default color will be used.
    public var toolbarColor: UIColor?

    // MARK: Properties - Buttons
    var hasButtons: Bool { hasNavigationButtons || hasDoneButton }

    /// Button tint color. Set to `nil`.
    ///
    /// When value is `nil`, default color will be used.
    public var buttonColor: UIColor?

    // MARK: Properties - Buttons - Navigation
    /// Indicates if toolbar has navigation buttons. Set to `true`.
    public var hasNavigationButtons: Bool = true

    // MARK: Properties - Buttons - Done
    /// Indicates if toolbar has done button. Set to `true`.
    public var hasDoneButton: Bool = true

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
}

#endif
