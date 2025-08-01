//
//  UIAlertViewable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.10.21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

/// Protocol for presenting a `UIAlert`.
///
///     final class ViewController: UIViewController, UIAlertViewable {
///         var viewModel: ViewModel!
///     }
///
///     final class ViewModel {
///         unowned let view: ViewController
///
///         init(view: ViewController) {
///             self.view = view
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

#if DEBUG

#Preview {
    final class ViewController: UIViewController, UIAlertViewable {
        // MARK: Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()

            let button: UIButton = .init()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Present", for: .normal)
            button.setTitleColor(UIColor.systemBlue, for: .normal)
            button.addAction(
                UIAction { [weak self] _ in self?.didTapPresentButton() },
                for: .touchUpInside
            )

            view.addSubview(button)

            NSLayoutConstraint.activate([
                button.constraintCenterX(to: view),
                button.constraintCenterY(to: view)
            ])
        }

        // MARK: Actions
        private func didTapPresentButton() {
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
