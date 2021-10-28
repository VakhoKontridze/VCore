//
//  StandardNavigatable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/10/21.
//

import UIKit

// MARK: - Standard Navigatable
/// Standard Navigatable that allows for navigation via `UINavigationController`.
///
/// In `VIPER` arhcitecute, this protocol is conformed by `UIViewController`,
/// or a protocol, which in turn `UIViewController` coforms to.
///
/// Methods have default implementations for `UIViewControllers`, except for `setRoot(to:)` method.
/// To implement this method, use the following snippet somewhere in the project:
///
///     extension StandardNavigatable where Self: ViewController {
///         func setRoot(to viewController: UIViewController) {
///             SceneDelegate.setRoot(to: viewController)
///         }
///     }
///
///     extension SceneDelegate {
///         static func setRoot(to viewController: UIViewController) {
///             guard
///                 let windowScene: UIWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
///                 let sceneDelegate: SceneDelegate = windowScene.delegate as? SceneDelegate
///             else {
///                 return
///             }
///
///             sceneDelegate.window?.rootViewController = viewController
///         }
///     }
///
public protocol StandardNavigatable {
    /// Pushes a view controller onto the receiver’s stack and updates the display.
    func push(_ viewController: UIViewController)
    
    /// Pops the top view controller from the navigation stack and updates the display.
    func pop()
    
    /// Pops all the view controllers on the stack except the root view controller and updates the display.
    func popToRoot()
    
    /// Presents a view controller modally.
    func present(_ viewController: UIViewController)
    
    /// Dismisses the view controller that was presented modally by the view controller.
    func dismiss()
    
    /// Sets view controller as root view controller and updates the display.
    func setRoot(to viewController: UIViewController)
}

extension StandardNavigatable where Self: UIViewController {
    public func push(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    public func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    public func present(_ viewController: UIViewController) {
        navigationController?.present(viewController, animated: true, completion: nil)
    }
    
    public func dismiss() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
