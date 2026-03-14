//
//  ResponderChainUIToolbarResponderParameters.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.11.23.
//

#if canImport(UIKit) && !(os(tvOS) || os(watchOS) || os(visionOS))

import Foundation

/// Parameter object that wraps `ResponderChainUIToolbarResponder` and it's UI customization.
public struct ResponderChainUIToolbarResponderParameters {
    // MARK: Properties
    /// `ResponderChainUIToolbarResponder`.
    public var responder: any ResponderChainUIToolbarResponder

    /// Toolbar appearance.
    public var toolBarAppearance: ResponderChainUIToolbarAppearance

    /// Toolbar size.
    public var toolBarSize: CGSize

    // MARK: Initializers
    /// Initializes `ResponderChainUIToolbarResponderParameters` with `ResponderChainUIToolbarResponder` and it's UI customization.
    public init(
        responder: ResponderChainUIToolbarResponder,
        toolBarAppearance: ResponderChainUIToolbarAppearance = .init(),
        toolBarSize: CGSize
    ) {
        self.responder = responder
        self.toolBarAppearance = toolBarAppearance
        self.toolBarSize = toolBarSize
    }
}

#endif
