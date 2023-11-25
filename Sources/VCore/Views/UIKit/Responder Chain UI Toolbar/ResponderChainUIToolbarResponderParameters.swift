//
//  ResponderChainUIToolbarResponderParameters.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.11.23.
//

#if canImport(UIKit) && !(os(tvOS) || os(watchOS))

import Foundation

// MARK: - Responder Chain UI Toolbar Responder Parameters
/// Parameter object that wraps `ResponderChainUIToolbarResponder` and it's UI customization.
public struct ResponderChainUIToolbarResponderParameters {
    // MARK: Properties
    /// `ResponderChainUIToolbarResponder`.
    public var responder: any ResponderChainUIToolbarResponder

    /// Toolbar ui model.
    public var toolBarUIModel: ResponderChainUIToolbarUIModel

    /// Toolbar size.
    public var toolBarSize: CGSize

    // MARK: Initializers
    /// Initializes `ResponderChainUIToolbarResponderParameters` with `ResponderChainUIToolbarResponder` and it's UI customization.
    public init(
        responder: ResponderChainUIToolbarResponder,
        toolBarUIModel: ResponderChainUIToolbarUIModel = .init(),
        toolBarSize: CGSize
    ) {
        self.responder = responder
        self.toolBarUIModel = toolBarUIModel
        self.toolBarSize = toolBarSize
    }
}

#endif
