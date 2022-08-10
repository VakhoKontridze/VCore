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

#endif
