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
///             AlertButton(action: { print("Confirmed") }, title: "Confirm")
///             AlertButton(role: .cancel, action: { print("Cancelled") }, title: "Cancel")
///         }
///     )
///
///     var body: some View {
///         content
///             .alert(parameters: $parameters)
///     }
///
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
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
                    action: completion,
                    title: VCoreLocalizationManager.shared.localizationProvider.alertOKButtonTitle
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
            title: VCoreLocalizationManager.shared.localizationProvider.alertErrorTitle,
            message: error.localizedDescription,
            actions: {
                AlertButton(
                    role: .cancel,
                    action: completion,
                    title: VCoreLocalizationManager.shared.localizationProvider.alertOKButtonTitle
                )
            }
        )
    }
}
