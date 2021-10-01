//
//  SwiftUIAlertViewModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/21/21.
//

import SwiftUI

// MARK: - SwiftUI Alert ViewModel
/// SwiftUI Alert ViewModel.
///
/// Viewmodel for presenting an `Alert`.
///
/// In `VIP` and `VIPER` arhcitecutes, viewmodel is stored in`Presenter`.
public enum SwiftUIAlertViewModel {
    // MARK: Cases
    /// One button.
    case oneButton(viewModel: OneButtonViewModel)
    
    /// Two button.
    case twoButtons(viewModel: TwoButtonsViewModel)

    // MARK: Button ViewModel
    /// Alert Button ViewModel.
    public struct AlertButtonViewModel {
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
        public let title: String
        
        /// Alert message.
        public let message: String?
        
        /// Alert dismiss button.
        public let dismissButton: AlertButtonViewModel
        
        /// Initializes viewmodel.
        public init(
            title: String,
            message: String?,
            dismissButton: AlertButtonViewModel
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
        public let title: String
        
        /// Alert message.
        public let message: String?
        
        /// Alert primary button.
        public let primaryButton: AlertButtonViewModel
        
        /// Alert secondary button.
        public let secondaryButton: AlertButtonViewModel
        
        /// Initializes viewmodel.
        public init(
            title: String,
            message: String?,
            primaryButton: AlertButtonViewModel,
            secondaryButton: AlertButtonViewModel
        ) {
            self.title = title
            self.message = message
            self.primaryButton = primaryButton
            self.secondaryButton = secondaryButton
        }
    }
}

// MARK: - Factory
extension View {
    /// Presents `Alert` when `viewModel` parameter is non-nil.
    @ViewBuilder public func alert(
        viewModel: Binding<SwiftUIAlertViewModel?>
    ) -> some View {
        let nulingAction: () -> Void = { viewModel.wrappedValue = nil }
        
        switch viewModel.wrappedValue {
        case nil:
            self
            
        case .oneButton(let oneButtonViewModel):
            self.alert(isPresented: .constant(true), content: {
                Alert(
                    title: .init(oneButtonViewModel.title),
                    message: oneButtonViewModel.message.let { .init($0) },
                    dismissButton: .build(viewModel: oneButtonViewModel.dismissButton, completion: nulingAction)
                )
            })
            
        case .twoButtons(let twoButtonsViewModel):
            self.alert(isPresented: .constant(true), content: {
                Alert(
                    title: .init(twoButtonsViewModel.title),
                    message: twoButtonsViewModel.message.let { .init($0) },
                    primaryButton: .build(viewModel: twoButtonsViewModel.primaryButton, completion: nulingAction),
                    secondaryButton: .build(viewModel: twoButtonsViewModel.secondaryButton, completion: nulingAction)
                )
            })
        }
    }
}

extension Alert.Button {
    fileprivate static func build(
        viewModel: SwiftUIAlertViewModel.AlertButtonViewModel,
        completion: @escaping () -> Void
    ) -> Alert.Button {
        .default(.init(viewModel.title), action: {
            viewModel.action?()
            completion()
        })
    }
}
