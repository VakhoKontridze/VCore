//
//  UIAlertViewable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.10.21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Alert Viewable
/// Porotocl for presenting an `UIAlert`.
///
/// `MVP`, `VIP`, and `VIPER` arhcitecutes, this protocol is conformed to by a `View/Controller`.
public protocol UIAlertViewable {
    /// Presents `UIAlert` with viewmodel
    func presentAlert(viewModel: UIAlertViewModel)
}

extension UIAlertViewable where Self: UIViewController {
    public func presentAlert(viewModel: UIAlertViewModel) {
        present(
            UIAlertController(viewModel: viewModel),
            animated: true,
            completion: nil
        )
    }
}

// MARK: - UI Alert ViewModel
/// Viewmodel for presenting an `UIAlert`.
///
/// `MVP`, `VIP`, and `VIPER` arhcitecutes, viewmodel is passed by`Presenter` to `View/Controller`
public struct UIAlertViewModel {
    // MARK: Properties
    /// Alert title.
    public var title: String?
    
    /// Alert message.
    public var message: String
    
    /// Actions.
    public var actions: [ButtonViewModel]
    
    // MARK: Initializers
    /// Initializes UIAlertViewModel.
    public init(
        title: String?,
        message: String,
        actions: [ButtonViewModel]
    ) {
        self.title = title
        self.message = message
        self.actions = actions
    }
    
    /// Initializes UIAlertViewModel with one action.
    public init(
        title: String?,
        message: String,
        action: ButtonViewModel
    ) {
        self.init(
            title: title,
            message: message,
            actions: [action]
        )
    }
    
    /// Initializes UIAlertViewModel with "ok" action.
    public init(
        title: String?,
        message: String,
        action: (() -> Void)?
    ) {
        self.init(
            title: title,
            message: message,
            action: .init(
                style: .cancel,
                title: VCoreLocalizationService.shared.localizationProvider.alertOKButtonTitle,
                action: action
            )
        )
    }
    
    /// Initializes UIAlertViewModel with error and "ok" action.
    public init(
        error: Error,
        action: (() -> Void)?
    ) {
        self.init(
            title: VCoreLocalizationService.shared.localizationProvider.alertErrorTitle,
            message: error.localizedDescription,
            action: .init(
                style: .cancel,
                title: VCoreLocalizationService.shared.localizationProvider.alertOKButtonTitle,
                action: action
            )
        )
    }
    
    // MARK: Button ViewModel
    /// Button ViewModel.
    public struct ButtonViewModel {
        /// Indicates if button is enabled.
        public var isEnabled: Bool
        
        /// Button style.
        public var style: UIAlertAction.Style
        
        /// Button title.
        public var title: String
        
        /// Button action.
        public var action: (() -> Void)?
        
        /// Initializes viewmodel.
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
    /// Initializes `UIAlertController` with `UIAlertViewModel`.
    public convenience init(viewModel: UIAlertViewModel) {
        self.init(
            title: viewModel.title ?? "", // Fixes weird bold bug when nil
            message: viewModel.message,
            preferredStyle: .alert
        )
        
        for action in viewModel.actions {
            addAction({
                let alertAction: UIAlertAction = .init(
                    title: action.title,
                    style: action.style,
                    handler: { _ in action.action?() }
                )
                
                alertAction.isEnabled = action.isEnabled
                
                return alertAction
            }())
        }
    }
}

#endif
