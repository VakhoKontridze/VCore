//
//  UIAlertViewable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.10.21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Alert Viewable
/// Protocol for presenting a `UIAlert`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, this `protocol` is conformed to by a `View/Controller`.
/// In `MVVM` architecture, this `protocol` is conformed to by a `View/Controller`.
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
///             view.presentAlert(
///                 parameters: UIAlertParameters(
///                     title: "Lorem Ipsum",
///                     message: "Lorem ipsum dolor sit amet",
///                     actions: {
///                         UIAlertButton(action: { print("Confirmed") }, title: "Confirm")
///                         UIAlertButton(action: { print("Cancelled") }, title: "Cancel", style: .cancel)
///                     }
///                 )
///             )
///         }
///     }
///
@MainActor
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

// MARK: - Preview
#if DEBUG

#Preview {
    final class ViewController: UIViewController, UIAlertViewable {
        override func viewDidLoad() {
            super.viewDidLoad()

            let button: UIButton = .init()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Present", for: .normal)
            button.setTitleColor(UIColor.systemBlue, for: .normal)
            button.addAction(
                UIAction { [weak self] _ in self?.present() },
                for: .touchUpInside
            )

            view.addSubview(button)

            NSLayoutConstraint.activate([
                button.constraintCenterX(to: view),
                button.constraintCenterY(to: view)
            ])
        }

        private func present() {
            presentAlert(
                parameters: UIAlertParameters(
                    title: "Lorem Ipsum",
                    message: "Lorem ipsum dolor sit amet",
                    actions: {
                        UIAlertButton(action: { print("Confirmed") }, title: "Confirm")
                        UIAlertButton(action: { print("Cancelled") }, title: "Cancel", style: .cancel)
                    }
                )
            )
        }
    }

    return ViewController()
}

#endif

#endif
