//
//  UIAlertViewable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.10.21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Alert Viewable
/// Protocol for presenting an `UIAlert`.
///
/// In `MVP`, `VIP`, and `VIPER` arhcitecutes, this protocol is conformed to by a `View/Controller`.
public protocol UIAlertViewable {
    /// Presents `UIAlert` with parameters
    func presentAlert(parameters: UIAlertParameters)
}

extension UIAlertViewable where Self: UIViewController {
    public func presentAlert(parameters: UIAlertParameters) {
        present(
            UIAlertController(parameters: parameters),
            animated: true,
            completion: nil
        )
    }
}

// MARK: - UI Alert Parameters
/// Parameters for presenting an `UIAlert`.
///
/// In `MVP`, `VIP`, and `VIPER` arhcitecutes, parameters are passed by`Presenter` to `View/Controller`
public struct UIAlertParameters {
    // MARK: Properties
    /// Alert title.
    public var title: String?
    
    /// Alert message.
    public var message: String
    
    /// Buttons.
    public var buttons: [Button]
    
    // MARK: Initializers
    /// Initializes `UIAlertParameters`.
    public init(
        title: String?,
        message: String,
        actions buttons: [Button]
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
    
    /// Initializes `UIAlertParameters` with one action.
    public init(
        title: String?,
        message: String,
        action button: Button
    ) {
        self.init(
            title: title,
            message: message,
            actions: [button]
        )
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
            action: .init(
                style: .cancel,
                title: VCoreLocalizationService.shared.localizationProvider.alertOKButtonTitle,
                action: completion
            )
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
            action: .init(
                style: .cancel,
                title: VCoreLocalizationService.shared.localizationProvider.alertOKButtonTitle,
                action: completion
            )
        )
    }
    
    // MARK: Button.
    /// Button.
    public struct Button {
        /// Indicates if button is enabled.
        public var isEnabled: Bool
        
        /// Button style.
        public var style: UIAlertAction.Style
        
        /// Button title.
        public var title: String
        
        /// Button action.
        public var action: (() -> Void)?
        
        /// Initializes `Button`.
        public init(
            isEnabled: Bool = true,
            style: UIAlertAction.Style = .default,
            title: String,
            action: (() -> Void)?
        ) {
            self.isEnabled = isEnabled
            self.style = style
            self.title = title
            self.action = action
        }
    }
}

// MARK: - Factory
extension UIAlertController {
    /// Initializes `UIAlertController` with `UIAlertParameters`.
    public convenience init(parameters: UIAlertParameters) {
        self.init(
            title: parameters.title ?? "", // Fixes weird bold bug when nil
            message: parameters.message,
            preferredStyle: .alert
        )
        
        for button in parameters.buttons {
            addAction({
                let alertAction: UIAlertAction = .init(
                    title: button.title,
                    style: button.style,
                    handler: { _ in button.action?() }
                )
                
                alertAction.isEnabled = button.isEnabled
                
                return alertAction
            }())
        }
    }
}

#endif
