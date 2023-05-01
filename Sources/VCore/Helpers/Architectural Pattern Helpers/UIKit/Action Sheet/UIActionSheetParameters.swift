//
//  UIActionSheetParameters.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.08.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Action Sheet Parameters
/// Parameters for presenting an `UIActionSheet`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, parameters are passed by`Presenter` to `View/Controller`
/// In `MVVM` architecture, parameters are passed by`ViewModel` to `View/Controller`
///
/// For usage example, refer to `UIActionSheetViewable`.
///
///     presentActionSheet(parameters: .init(
///         title: "Lorem Ipsum",
///         message: "Lorem ipsum dolor sit amet",
///         actions: {
///             UIActionSheetButton(title: "Confirm", action: { print("Confirmed") })
///             UIActionSheetButton(style: .cancel, title: "Cancel", action: { print("Cancelled") })
///         }
///     ))
///
public struct UIActionSheetParameters {
    // MARK: Properties
    /// Title.
    public var title: String?
    
    /// Message.
    public var message: String?
    
    /// Buttons.
    public var buttons: () -> [UIActionSheetButton]
    
    // MARK: Initializers
    /// Initializes `UIActionSheetParameters`.
    public init(
        title: String?,
        message: String?,
        @UIActionSheetButtonBuilder actions buttons: @escaping () -> [UIActionSheetButton]
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
        
        parameters.buttons().forEach { addAction($0.makeBody()) }
    }
}

#endif
