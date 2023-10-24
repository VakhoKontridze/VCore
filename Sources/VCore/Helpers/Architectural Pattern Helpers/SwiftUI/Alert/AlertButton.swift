//
//  AlertButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

import SwiftUI

// MARK: - Alert Button
/// `Alert` button.
public struct AlertButton: AlertButtonProtocol {
    // MARK: Properties
    private var isEnabled: Bool = true
    private let role: ButtonRole?
    private let title: String
    private let action: (() -> Void)?
    
    // MARK: Initializers
    /// Initializes `AlertButton`.
    public init(
        role: ButtonRole? = nil,
        action: (() -> Void)?,
        title: String
    ) {
        self.role = role
        self.title = title
        self.action = action
    }

    // MARK: Identifiable
    public var id: Int { title.hashValue }

    // MARK: Button Protocol
    public func makeBody(
        animateOutHandler: @escaping (/*completion*/ (() -> Void)?) -> Void
    ) -> AnyView {
        .init(
            Button(
                title,
                role: role,
                action: { animateOutHandler(/*completion: */action) }
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
