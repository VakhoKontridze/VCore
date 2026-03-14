//
//  UIActionSheetViewable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.08.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

/// Protocol for presenting a `UIActionSheet`.
///
///     final class ViewController: UIViewController, UIActionSheetViewable {
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

#if DEBUG

#Preview {
    final class ViewController: UIViewController, UIActionSheetViewable {
        // MARK: Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()

            let button: UIButton = .init()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Present", for: .normal)
            button.setTitleColor(UIColor.systemBlue, for: .normal)
            button.addAction(
                UIAction { [weak self] _ in self?.onPresent() },
                for: .touchUpInside
            )

            view.addSubview(button)

            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }

        // MARK: Actions
        private func onPresent() {
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
