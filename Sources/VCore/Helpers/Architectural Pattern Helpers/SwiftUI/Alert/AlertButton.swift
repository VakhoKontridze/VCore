//
//  AlertButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

import SwiftUI

// MARK: - Alert Button Protocol
/// `Alert` button protocol.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public protocol AlertButtonProtocol: AlertButtonConvertible {
    /// Body type.
    typealias Body = AnyView
    
    /// Body.
    func body(
        animateOut: @escaping (/*completion*/ (() -> Void)?) -> Void
    ) -> Body
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension AlertButtonProtocol {
    public func toButtons() -> [any AlertButtonProtocol] { [self] }
}

// MARK: - Alert Button
/// `Alert` button.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct AlertButton: AlertButtonProtocol {
    // MARK: Properties
    private var isEnabled: Bool = true
    
    /// Button role.
    public let role: ButtonRole?
    
    /// Button title.
    public var title: String
    
    /// Button action.
    public var action: (() -> Void)?
    
    // MARK: Initializes
    /// Initializes `AlertButton`.
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
