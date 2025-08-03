//
//  AlertParameters.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/21/21.
//

import SwiftUI

/// Parameters for presenting an `Alert`.
public struct AlertParameters {
    // MARK: Properties
    /// Title.
    public var title: String?

    /// Message.
    public var message: String?

    /// Buttons.
    public var buttons: () -> [any AlertButtonProtocol]

    /// Attributes.
    public var attributes: [String: Any?]

    // MARK: Parameters
    /// Initializes `AlertParameters`.
    public init(
        title: String?,
        message: String?,
        @AlertButtonBuilder actions buttons: @escaping () -> [any AlertButtonProtocol],
        attributes: [String: Any?] = [:]
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
        self.attributes = attributes
    }
    
    /// Initializes `AlertParameters` with action.
    public init(
        title: String?,
        message: String?,
        completion: (@MainActor () -> Void)?,
        attributes: [String: Any?] = [:]
    ) {
        self.init(
            title: title,
            message: message,
            actions: {
                AlertButton(
                    action: completion,
                    title: VCoreLocalizationManager.shared.localizationProvider.alertOKButtonTitle,
                    role: .cancel
                )
            },
            attributes: attributes
        )
    }
    
    /// Initializes `AlertParameters` with error and action.
    public init(
        error: any Error,
        completion: (@MainActor () -> Void)?,
        attributes: [String: Any?] = [:]
    ) {
        self.init(
            title: VCoreLocalizationManager.shared.localizationProvider.alertErrorTitle,
            message: error.localizedDescription,
            actions: {
                AlertButton(
                    action: completion,
                    title: VCoreLocalizationManager.shared.localizationProvider.alertOKButtonTitle,
                    role: .cancel
                )
            },
            attributes: attributes
        )
    }
}
