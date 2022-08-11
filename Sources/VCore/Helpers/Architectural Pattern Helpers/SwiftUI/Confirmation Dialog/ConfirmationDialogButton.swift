//
//  ConfirmationDialogButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.08.22.
//

import SwiftUI

// MARK: - Confirmation Dialog Button Protocol
/// `ConfirmationDialog` button protocol.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public protocol ConfirmationDialogButtonProtocol: ConfirmationDialogButtonConvertible {
    /// Body type.
    typealias Body = AnyView
    
    /// Body.
    func body(
        animateOut: @escaping (/*completion*/ (() -> Void)?) -> Void
    ) -> Body
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension ConfirmationDialogButtonProtocol {
    public func toButtons() -> [any ConfirmationDialogButtonProtocol] { [self] }
}

// MARK: - Confirmation Dialog Button
/// `ConfirmationDialog` button.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct ConfirmationDialogButton: ConfirmationDialogButtonProtocol {
    // MARK: Properties
    private var isEnabled: Bool = true
    private let role: ButtonRole?
    private let title: String
    private let action: (() -> Void)?
    
    // MARK: Initializers
    /// Initializes `ConfirmationDialogButton`.
    public init(
        role: ButtonRole? = nil,
        title: String,
        action: (() -> Void)?
    ) {
        self.role = role
        self.title = title
        self.action = action
    }
    
    // MARK: Body
    public func body(
        animateOut: @escaping (/*completion*/ (() -> Void)?) -> Void
    ) -> AnyView {
        .init(
            Button(
                title,
                role: role,
                action: { animateOut(/*completion: */action) }
            )
                .disabled(!isEnabled)
        )
    }
    
    // MARK: Modifiers
    /// Adds a condition that controls whether users can interact with the button.
    public func disabled(_ disabled: Bool) -> Self {
        var button = self
        button.isEnabled = !disabled
        return button
    }
}
