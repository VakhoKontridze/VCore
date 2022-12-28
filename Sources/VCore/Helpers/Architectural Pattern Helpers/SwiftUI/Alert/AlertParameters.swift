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
/// In `MVP`, `VIP`, and `VIPER` architectures, parameters are stored in`Presenter`.
/// in `MVVM` architecture, parameters are stored in `ViewModel.`
///
///     @State private var parameters: AlertParameters? = .init(
///         title: "Lorem Ipsum",
///         message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
///         actions: {
///             AlertButton(title: "Confirm", action: { print("Confirmed") })
///             AlertButton(role: .cancel, title: "Cancel", action: { print("Cancelled") })
///         }
///     )
///
///     var body: some View {
///         content
///             .alert(parameters: $parameters)
///     }
///
@available(iOS 15.0, *)
@available(macOS 12.0, *)
@available(tvOS 15.0, *)
@available(watchOS 8.0, *)
public struct AlertParameters {
    // MARK: Properties
    /// Title.
    public var title: String
    
    /// Message.
    public var message: String?
    
    /// Buttons.
    public var buttons: () -> [any AlertButtonProtocol]
    
    // MARK: Parameters
    /// Initializes `AlertParameters`.
    public init(
        title: String,
        message: String?,
        @AlertButtonBuilder actions buttons: @escaping () -> [any AlertButtonProtocol]
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }

    /// Initializes `AlertParameters` with "ok" action.
    public init(
        title: String,
        message: String?,
        completion: (() -> Void)?
    ) {
        self.init(
            title: title,
            message: message,
            actions: {
                AlertButton(
                    role: .cancel,
                    title: VCoreLocalizationService.shared.localizationProvider.alertOKButtonTitle,
                    action: completion
                )
            }
        )
    }

    /// Initializes `AlertParameters` with error and "ok" action.
    public init(
        error: some Error,
        completion: (() -> Void)?
    ) {
        self.init(
            title: VCoreLocalizationService.shared.localizationProvider.alertErrorTitle,
            message: error.localizedDescription,
            actions: {
                AlertButton(
                    role: .cancel,
                    title: VCoreLocalizationService.shared.localizationProvider.alertOKButtonTitle,
                    action: completion
                )
            }
        )
    }
}
