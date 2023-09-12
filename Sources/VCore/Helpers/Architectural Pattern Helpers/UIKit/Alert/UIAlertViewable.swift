//
//  UIAlertViewable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.10.21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Alert Viewable
/// Protocol for presenting an `UIAlert`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, this protocol is conformed to by a `View/Controller`.
/// In `MVVM` architecture, this protocol is conformed to by a `View/Controller`.
///
///     final class ViewController: UIViewController, UIAlertViewable {
///         var presenter: Presenter!
///     }
///
///     final class Presenter {
///         unowned let view: ViewController
///
///         init(view: ViewController) {
///             ...
///         }
///
///         func present() {
///             view.presentActionSheet(parameters: UIAlertParameters(
///                 title: "Lorem Ipsum",
///                 message: "Lorem ipsum dolor sit amet",
///                 actions: {
///                     UIAlertButton(title: "Confirm", action: { print("Confirmed") })
///                     UIAlertButton(style: .cancel, title: "Cancel", action: { print("Cancelled") })
///                 }
///             ))
///         }
///     }
///
public protocol UIAlertViewable {
    /// Presents `UIAlert` with parameters
    func presentAlert(parameters: UIAlertParameters)
}

extension UIAlertViewable where Self: UIViewController {
    public func presentAlert(parameters: UIAlertParameters) {
        present(
            UIAlertController(parameters: parameters),
            animated: true,
            completion: nil
        )
    }
}

#endif
