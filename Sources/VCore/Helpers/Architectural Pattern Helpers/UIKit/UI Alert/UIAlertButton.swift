//
//  UIAlertButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Alert Button
/// `UIAlertController` button.
public struct UIAlertButton: UIAlertButtonProtocol {
    // MARK: Properties
    /// Indicates if button is enabled.
    public var isEnabled: Bool
    
    /// Action.
    public var action: (@MainActor () -> Void)?
    
    /// Title.
    public var title: String
    
    /// Style.
    public var style: UIAlertAction.Style
    
    // MARK: Initializers
    /// Initializes `UIAlertButton`.
    public init(
        isEnabled: Bool = true,
        action: (@MainActor () -> Void)?,
        title: String,
        style: UIAlertAction.Style = .default
    ) {
        self.isEnabled = isEnabled
        self.action = action
        self.title = title
        self.style = style
    }
    
    // MARK: Button Protocol
    public func makeBody() -> UIAlertAction {
        let alertAction: UIAlertAction = .init(
            title: title,
            style: style
        ) { _ in
            action?()
        }
        alertAction.isEnabled = isEnabled

        return alertAction
    }
}

#endif
