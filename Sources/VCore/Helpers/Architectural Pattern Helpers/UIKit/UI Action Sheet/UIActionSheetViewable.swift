//
//  UIActionSheetViewable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.08.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Action Sheet Viewable
/// Protocol for presenting a `UIActionSheet`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, this `protocol` is conformed to by a `View/Controller`.
/// In `MVVM` architecture, this `protocol` is conformed to by a `View/Controller`.
///
///     final class ViewController: UIViewController, UIActionSheetViewable {
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
///             view.presentActionSheet(
///                 parameters: UIActionSheetParameters(
///                     title: "Lorem Ipsum",
///                     message: "Lorem ipsum dolor sit amet",
///                     actions: {
///                         UIActionSheetButton(action: { print("Confirmed") }, title: "Confirm")
///                         UIActionSheetButton(action: { print("Cancelled") }, title: "Cancel", style: .cancel)
///                     }
///                 )
///             )
///         }
///     }
///
@MainActor
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

// MARK: - Preview
#if DEBUG

#Preview {
    final class ViewController: UIViewController, UIActionSheetViewable {
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
            presentActionSheet(
                parameters: UIActionSheetParameters(
                    title: "Lorem Ipsum",
                    message: "Lorem ipsum dolor sit amet",
                    actions: {
                        UIActionSheetButton(action: { print("Confirmed") }, title: "Confirm")
                        UIActionSheetButton(action: { print("Cancelled") }, title: "Cancel", style: .cancel)
                    }
                )
            )
        }
    }

    return ViewController()
}

#endif

#endif
