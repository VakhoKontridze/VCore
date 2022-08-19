//
//  UIAlertParameters.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Alert Parameters
/// Parameters for presenting an `UIAlert`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, parameters are passed by`Presenter` to `View/Controller`
/// In `MVVM` architecture, parameters are passed by`ViewModel` to `View/Controller`
///
/// For usage example, refer to `UIAlertViewable`.
public struct UIAlertParameters {
    // MARK: Properties
    /// Title.
    public var title: String?
    
    /// Message.
    public var message: String
    
    /// Buttons.
    public var buttons: () -> [any UIAlertButtonProtocol]
    
    // MARK: Initializers
    /// Initializes `UIAlertParameters`.
    public init(
        title: String?,
        message: String,
        @UIAlertButtonBuilder actions buttons: @escaping () -> [any UIAlertButtonProtocol]
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
    
    /// Initializes `UIAlertParameters` with "ok" action.
    public init(
        title: String?,
        message: String,
        completion: (() -> Void)?
    ) {
        self.init(
            title: title,
            message: message,
            actions: {
                UIAlertButton(
                    style: .cancel,
                    title: VCoreLocalizationService.shared.localizationProvider.alertOKButtonTitle,
                    action: completion
                )
            }
        )
    }
    
    /// Initializes `UIAlertParameters` with error and "ok" action.
    public init(
        error: Error,
        completion: (() -> Void)?
    ) {
        self.init(
            title: VCoreLocalizationService.shared.localizationProvider.alertErrorTitle,
            message: error.localizedDescription,
            actions: {
                UIAlertButton(
                    style: .cancel,
                    title: VCoreLocalizationService.shared.localizationProvider.alertOKButtonTitle,
                    action: completion
                )
            }
        )
    }
}

// MARK: - Factory
extension UIAlertController {
    /// Initializes `UIAlertController` with `UIAlertParameters`.
    public convenience init(parameters: UIAlertParameters) {
        self.init(
            title: parameters.title ?? "", // Fixes weird bold bug when `nil`
            message: parameters.message,
            preferredStyle: .alert
        )
        
        parameters.buttons().forEach { addAction($0.toUIAlertAction) }
    }
}

#endif