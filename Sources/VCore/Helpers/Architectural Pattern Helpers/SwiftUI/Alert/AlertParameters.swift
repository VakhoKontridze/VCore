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
///     @State private var parameters: AlertParameters?
///
///     var body: some View {
///         Button("Lorem ipsum", action: {
///             parameters = AlertParameters(
///                 title: "Lorem Ipsum",
///                 message: "Lorem ipsum",
///                 actions: {
///                     AlertButton(title: "Confirm", action: { print("Confirmed") })
///                     AlertButton(role: .cancel, title: "Cancel", action: { print("Cancelled") })
///                 }
///             )
///         })
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
                    title: VCoreLocalizationService.shared.localizationProvider.alertOKButtonTitle,
                    action: completion
                )
            }
        )
    }

    /// Initializes `AlertParameters` with error and "ok" action.
    public init(
        error: Error,
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

// MARK: - Factory
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension View {
    /// Presents `Alert` when `AlertParameters` is non-`nil`.
    @ViewBuilder public func alert(
        parameters: Binding<AlertParameters?>
    ) -> some View {
        switch parameters.wrappedValue {
        case nil:
            self

        case let _parameters?:
            self.alert(
                _parameters.title,
                isPresented: .constant(true),
                actions: {
                    ForEach(_parameters.buttons().enumeratedArray(), id: \.offset, content: { (_, button) in
                        button.body(
                            animateOut: {
                                parameters.wrappedValue = nil
                                $0?()
                            }
                        )
                    })
                },
                message: {
                    if let message: String = _parameters.message {
                        Text(message)
                    }
                }
            )
        }
    }
}
