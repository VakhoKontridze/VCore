//
//  ConfirmationDialogButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.08.22.
//

import SwiftUI

// MARK: - Confirmation Dialog Button
/// `ConfirmationDialog` button.
public struct ConfirmationDialogButton: ConfirmationDialogButtonProtocol {
    // MARK: Properties
    private var isEnabled: Bool = true
    private let action: (@MainActor () -> Void)?
    private let title: String
    private let role: ButtonRole?
    
    // MARK: Initializers
    /// Initializes `ConfirmationDialogButton`.
    public init(
        action: (@MainActor () -> Void)?,
        title: String,
        role: ButtonRole? = nil
    ) {
        self.action = action
        self.title = title
        self.role = role
    }

    // MARK: Button Protocol
    public func makeBody(
        animateOutHandler: @escaping (/*completion*/ (() -> Void)?) -> Void
    ) -> AnyView {
        Button(
            title,
            role: role
        ) {
            animateOutHandler(/*completion: */action)
        }
        .disabled(!isEnabled)
        .eraseToAnyView()
    }
    
    // MARK: Modifiers
    /// Adds a condition that controls whether users can interact with the button.
    public func disabled(_ disabled: Bool) -> Self {
        var button = self
        button.isEnabled = !disabled
        return button
    }
}
