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
/// In `VIPER` arhcitecute, this protocol is conformed to by a `View/Controller`.
public protocol UIAlertViewable {
    /// Presents `UIAlert` with viewmodel
    func presentAlert(viewModel: UIAlertViewModel)
}

extension UIAlertViewable where Self: UIViewController {
    public func presentAlert(viewModel: UIAlertViewModel) {
        present(
            viewModel.uiAlertController,
            animated: true,
            completion: nil
        )
    }
}

// MARK: - UI Alert ViewModel
/// Viewmodel for presenting an `UIAlert`.
///
/// In `VIPER` arhcitecute, viewmodel is passed by`Presenter` to `View/Controller`
public enum UIAlertViewModel {
    // MARK: Cases
    /// One button.
    case oneButton(viewModel: OneButtonViewModel)
    
    /// Two button.
    case twoButtons(viewModel: TwoButtonsViewModel)

    // MARK: Button ViewModel
    /// Button ViewModel.
    public struct ButtonViewModel {
        /// Button title.
        public let title: String
        
        /// Button action.
        public let action: (() -> Void)?
        
        /// Initializes viewmodel.
        public init(
            title: String,
            action: (() -> Void)?
        ) {
            self.title = title
            self.action = action
        }
    }

    // MARK: One Button ViewModel
    /// One Button ViewModel.
    public struct OneButtonViewModel {
        /// Alert title.
        public let title: String?
        
        /// Alert message.
        public let message: String
        
        /// Alert dismiss button.
        public let dismissButton: ButtonViewModel
        
        /// Initializes viewmodel.
        public init(
            title: String?,
            message: String,
            dismissButton: ButtonViewModel
        ) {
            self.title = title
            self.message = message
            self.dismissButton = dismissButton
        }
    }

    // MARK: Two Buttons ViewModel
    /// Two Buttons ViewModel.
    public struct TwoButtonsViewModel {
        /// Alert title.
        public let title: String?
        
        /// Alert message.
        public let message: String
        
        /// Alert primary button.
        public let primaryButton: ButtonViewModel
        
        /// Alert secondary button.
        public let secondaryButton: ButtonViewModel
        
        /// Initializes viewmodel.
        public init(
            title: String?,
            message: String,
            primaryButton: ButtonViewModel,
            secondaryButton: ButtonViewModel
        ) {
            self.title = title
            self.message = message
            self.primaryButton = primaryButton
            self.secondaryButton = secondaryButton
        }
    }
    
    // MARK: Factory
    /// Creates `UIAlertController` from viewmodel
    public var uiAlertController: UIAlertController {
        switch self {
        case .oneButton(let viewModel):
            let alert: UIAlertController = .init(
                title: viewModel.title ?? "", // Fixes weird bold bug when nil
                message: viewModel.message,
                preferredStyle: .alert
            )
            
            alert.addAction(.init(
                title: viewModel.dismissButton.title,
                style: .cancel,
                handler: { _ in viewModel.dismissButton.action?() }
            ))
            
            return alert
            
        case .twoButtons(let viewModel):
            let alert: UIAlertController = .init(
                title: viewModel.title ?? "", // Fixes weird bold bug when nil
                message: viewModel.message,
                preferredStyle: .alert
            )
            
            alert.addAction(.init(
                title: viewModel.primaryButton.title,
                style: .default,
                handler: { _ in viewModel.primaryButton.action?() }
            ))
            
            alert.addAction(.init(
                title: viewModel.secondaryButton.title,
                style: .cancel,
                handler: { _ in viewModel.secondaryButton.action?() }
            ))
            
            return alert
        }
    }
}

#endif
