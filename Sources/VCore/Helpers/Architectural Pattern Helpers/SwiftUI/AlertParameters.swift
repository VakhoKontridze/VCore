//
//  AlertParameters.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/21/21.
//

import SwiftUI

// MARK: - Alert Parameters
/// Alert Parameters.
///
/// Parameters for presenting an `Alert`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, parameters are stored in`Presenter`.
/// in `MVVM`, parameters are stored in `ViewModel.`
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct AlertParameters: Hashable, Identifiable {
    // MARK: Properties
    /// Alert title.
    public var title: String
    
    /// Alert message.
    public var message: String?
    
    /// Buttons.
    public var buttons: [Button]
    
    // MARK: Parameters
    /// Initializes `AlertParameters`.
    public init(
        title: String,
        message: String?,
        actions buttons: [Button]
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
    
    /// Initializes `AlertParameters` with one action.
    public init(
        title: String,
        message: String?,
        action button: Button
    ) {
        self.init(
            title: title,
            message: message,
            actions: [button]
        )
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
            action: .init(
                role: .cancel,
                title: VCoreLocalizationService.shared.localizationProvider.alertOKButtonTitle,
                action: completion
            )
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
            action: .init(
                role: .cancel,
                title: VCoreLocalizationService.shared.localizationProvider.alertOKButtonTitle,
                action: completion
            )
        )
    }
    
    // MARK: Button
    /// Button.
    public struct Button: Hashable, Identifiable, Equatable {
        // MARK: Properties
        public let id: UUID
        
        /// Indicates if button is enabled.
        public var isEnabled: Bool
        
        /// Button role.
        public let role: ButtonRole?
        
        /// Button title.
        public var title: String
        
        /// Button action.
        public var action: (() -> Void)?
        
        /// Initializes `Button`.
        public init(
            isEnabled: Bool = true,
            role: ButtonRole? = nil,
            title: String,
            action: (() -> Void)?
        ) {
            self.id = .init()
            self.isEnabled = isEnabled
            self.role = role
            self.title = title
            self.action = action
        }
        
        // MARK: Hashable
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        // MARK: Equatable
        public static func == (lhs: AlertParameters.Button, rhs: AlertParameters.Button) -> Bool {
            isEqual(lhs, to: rhs, by: \.id)
        }
    }
    
    // MARK: Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(message)
        hasher.combine(buttons)
    }
    
    // MARK: Identifiable
    public var id: Int { hashValue }
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
                    ForEach(_parameters.buttons.enumeratedArray(), id: \.offset, content: { (_, button) in
                        Button(
                            parameters: button,
                            completion: { parameters.wrappedValue = nil }
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

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension Button {
    fileprivate init(
        parameters: AlertParameters.Button,
        completion: @escaping () -> Void
    ) where Label == Text {
        self.init(
            parameters.title,
            role: parameters.role,
            action: {
                parameters.action?()
                completion()
            }
        )
    }
}
