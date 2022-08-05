//
//  UIActionSheetViewable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.08.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Action Sheet Viewable
/// Protocol for presenting an `UIActionSheet`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, this protocol is conformed to by a `View/Controller`.
/// In `MVVM` architecture, this protocol is conformed to by a `View/Controller`.
///
///     presentActionSheet(parameters: .init(
///         title: "Lorem Ipsum",
///         message: "Lorem ipsum",
///         actions: {
///             UIActionSheetButton(title: "Confirm", action: { print("Confirmed") })
///             UIActionSheetButton(style: .cancel, title: "Cancel", action: { print("Cancelled") })
///         }
///     ))
///
public protocol UIActionSheetViewable {
    /// Presents `UIActionSheet` with parameters
    func presentActionSheet(parameters: UIActionSheetParameters)
}

extension UIActionSheetViewable where Self: UIViewController {
    public func presentActionSheet(parameters: UIActionSheetParameters) {
        present(
            UIAlertController(parameters: parameters),
            animated: true,
            completion: nil
        )
    }
}

// MARK: - UI Action Sheet Parameters
/// Parameters for presenting an `UIActionSheet`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, parameters are passed by`Presenter` to `View/Controller`
/// In `MVVM` architecture, parameters are passed by`ViewModel` to `View/Controller`
///
/// For usage example, refer to `UIActionSheetViewable`.
public struct UIActionSheetParameters {
    // MARK: Properties
    /// Action sheet title.
    public var title: String?
    
    /// Action sheet message.
    public var message: String?
    
    /// Buttons.
    public var buttons: () -> [any UIActionSheetButtonProtocol]
    
    // MARK: Initializers
    /// Initializes `UIActionSheetParameters`.
    public init(
        title: String?,
        message: String?,
        @UIActionSheetButtonBuilder actions buttons: @escaping () -> [any UIActionSheetButtonProtocol]
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
}

// MARK: - Factory
extension UIAlertController {
    /// Initializes `UIAlertController` with `UIActionSheetParameters`.
    public convenience init(parameters: UIActionSheetParameters) {
        self.init(
            title: parameters.title,
            message: parameters.message,
            preferredStyle: .actionSheet
        )

        parameters.buttons().forEach { addAction($0.toUIAlertAction) }
    }
}

#endif
