//
//  AlertButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

import SwiftUI

// MARK: - Alert Button
/// `Alert` button.
public struct AlertButton: AlertButtonProtocol, Sendable {
    // MARK: Properties
    private var isEnabled: Bool = true
    private let role: ButtonRole?
    private let title: String
    private let action: (@Sendable () -> Void)?
    
    // MARK: Initializers
    /// Initializes `AlertButton`.
    public init(
        role: ButtonRole? = nil,
        action: (@Sendable () -> Void)?,
        title: String
    ) {
        self.role = role
        self.title = title
        self.action = action
    }

    // MARK: Button Protocol
    public func makeBody(
        animateOutHandler: @escaping (/*completion*/ (() -> Void)?) -> Void
    ) -> AnyView {
        Button(
            title,
            role: role,
            action: { animateOutHandler(/*completion: */action) }
        )
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
