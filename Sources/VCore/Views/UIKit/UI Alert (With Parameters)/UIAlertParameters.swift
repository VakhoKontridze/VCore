//
//  UIAlertParameters.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Alert Parameters
/// Parameters for presenting a `UIAlert`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, parameters are passed by`Presenter` to `View/Controller`
/// In `MVVM` architecture, parameters are passed by`ViewModel` to `View/Controller`
///
/// For usage example, refer to `UIAlertViewable`.
///
///     presentAlert(
///         parameters: UIAlertParameters(
///             title: "Lorem Ipsum",
///             message: "Lorem ipsum dolor sit amet",
///             actions: {
///                 UIAlertButton(action: { print("Confirmed") }, title: "Confirm")
///                 UIAlertButton(action: { print("Cancelled") }, title: "Cancel", style: .cancel)
///             }
///         )
///     )
///
public struct UIAlertParameters {
    // MARK: Properties
    /// Title.
    public var title: String?
    
    /// Message.
    public var message: String
    
    /// Buttons.
    public var buttons: @MainActor () -> [any UIAlertButtonProtocol]
    
    // MARK: Initializers
    /// Initializes `UIAlertParameters`.
    public init(
        title: String?,
        message: String,
        @UIAlertButtonBuilder actions buttons: @escaping @MainActor () -> [any UIAlertButtonProtocol]
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
    
    /// Initializes `UIAlertParameters` with "ok" action.
    public init(
        title: String?,
        message: String,
        completion: (@MainActor () -> Void)?
    ) {
        self.init(
            title: title,
            message: message,
            actions: {
                UIAlertButton(
                    action: completion,
                    title: VCoreLocalizationManager.shared.localizationProvider.alertOKButtonTitle,
                    style: .cancel
                )
            }
        )
    }
    
    /// Initializes `UIAlertParameters` with error and "ok" action.
    public init(
        error: any Error,
        completion: (@MainActor () -> Void)?
    ) {
        self.init(
            title: VCoreLocalizationManager.shared.localizationProvider.alertErrorTitle,
            message: error.localizedDescription,
            actions: {
                UIAlertButton(
                    action: completion,
                    title: VCoreLocalizationManager.shared.localizationProvider.alertOKButtonTitle,
                    style: .cancel
                )
            }
        )
    }
}

// MARK: - Factory
extension UIAlertController {
    /// Initializes `UIAlertController` with `UIAlertParameters`.
    convenience public init(parameters: UIAlertParameters) {
        self.init(
            title: parameters.title ?? "", // Fixes weird bold bug when `nil`
            message: parameters.message,
            preferredStyle: .alert
        )
        
        parameters.buttons().forEach { addAction($0.makeBody()) }
    }
}

#endif
