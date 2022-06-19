//
//  StandardNavigable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Standard Navigable
/// Standard Navigable that allows for navigation via `UINavigationController`.
///
/// In `MVP`, `VIP`, and `VIPER` arhcitecutes, this protocol is conformed by `UIViewController`,
/// or a protocol, which in turn `UIViewController` coforms to.
///
/// Methods have default implementations for `UIViewControllers`, except for `setRoot(to:)` method.
/// To implement this method, use the following snippet somewhere in the project:
///
///     extension StandardNavigable where Self: UIViewController {
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
public protocol StandardNavigable {
    /// Pushes a view controller onto the receiver’s stack and updates the display.
    func push(_ viewController: UIViewController, animated: Bool)
    
    /// Pops the top view controller from the navigation stack and updates the display.
    func pop(animated: Bool)
    
    /// Pops all the view controllers on the stack except the root view controller and updates the display.
    func popToRoot(animated: Bool)
    
    /// Presents a view controller modally.
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    
    /// Dismisses the view controller that was presented modally by the view controller.
    func dismiss(animated: Bool, completion: (() -> Void)?)
    
    /// Sets view controller as root view controller and updates the display.
    func setRoot(to viewController: UIViewController)
}

extension StandardNavigable {
    /// Pushes a view controller onto the receiver’s stack and updates the display.
    public func push(_ viewController: UIViewController) {
        push(viewController, animated: true)
    }
    
    /// Pops the top view controller from the navigation stack and updates the display.
    public func pop() {
        pop(animated: true)
    }
    
    /// Pops all the view controllers on the stack except the root view controller and updates the display.
    public func popToRoot() {
        popToRoot(animated: true)
    }
    
    /// Presents a view controller modally.
    public func present(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    /// Dismisses the view controller that was presented modally by the view controller.
    public func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}

extension StandardNavigable where Self: UIViewController {
    public func push(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    public func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    public func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        navigationController?.present(viewController, animated: animated, completion: completion)
    }
    
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }
}

#endif
