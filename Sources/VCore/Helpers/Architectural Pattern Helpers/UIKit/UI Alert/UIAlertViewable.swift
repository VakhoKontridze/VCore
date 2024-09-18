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
///                         UIAlertButton(title: "Confirm", action: { print("Confirmed") })
///                        UIAlertButton(style: .cancel, title: "Cancel", action: { print("Cancelled") })
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

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview(body: {
    final class ViewController: UIViewController, UIAlertViewable {
        override func viewDidLoad() {
            super.viewDidLoad()

            let button: UIButton = .init()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Present", for: .normal)
            button.setTitleColor(UIColor.systemBlue, for: .normal)
            button.addAction(
                UIAction(handler: { [weak self] _ in self?.present() }),
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
                        UIAlertButton(title: "Confirm", action: { print("Confirmed") })
                        UIAlertButton(style: .cancel, title: "Cancel", action: { print("Cancelled") })
                    }
                )
            )
        }
    }

    return ViewController()
})

#endif

#endif
