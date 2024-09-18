//
//  AlertParameters.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/21/21.
//

import SwiftUI

// MARK: - Alert Parameters
/// Parameters for presenting an `Alert`.
///
///     @State private var parameters: AlertParameters?
///
///     var body: some View {
///         Button(
///             "Present",
///             action: {
///                 parameters = AlertParameters(
///                     title: "Lorem Ipsum",
///                     message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
///                     actions: {
///                         AlertButton(action: { print("Confirmed") }, title: "Confirm")
///                         AlertButton(role: .cancel, action: { print("Cancelled") }, title: "Cancel")
///                     }
///                 )
///             }
///         )
///         .alert(parameters: $parameters)
///     }
///
@MainActor
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
    
    /// Initializes `AlertParameters` with "ok" action.
    public init(
        title: String?,
        message: String?,
        completion: (() -> Void)?,
        attributes: [String: Any?] = [:]
    ) {
        self.init(
            title: title,
            message: message,
            actions: {
                AlertButton(
                    role: .cancel,
                    action: completion,
                    title: VCoreLocalizationManager.shared.localizationProvider.alertOKButtonTitle
                )
            },
            attributes: attributes
        )
    }
    
    /// Initializes `AlertParameters` with error and "ok" action.
    public init(
        error: any Error,
        completion: (() -> Void)?,
        attributes: [String: Any?] = [:]
    ) {
        self.init(
            title: VCoreLocalizationManager.shared.localizationProvider.alertErrorTitle,
            message: error.localizedDescription,
            actions: {
                AlertButton(
                    role: .cancel,
                    action: completion,
                    title: VCoreLocalizationManager.shared.localizationProvider.alertOKButtonTitle
                )
            },
            attributes: attributes
        )
    }
}
