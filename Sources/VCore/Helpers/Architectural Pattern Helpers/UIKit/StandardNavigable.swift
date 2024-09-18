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
/// In `MVP`, `VIP`, and `VIPER` architectures, this `protocol` is conformed by a `View/Controller`.
/// In `MVVM` architecture, this `protocol` is conformed to by a `View/Controller`.
///
///     final class ViewController: UIViewController, StandardNavigable {
///         var presenter: Presenter!
///
///         func didTapButton() {
///             presenter.didTapButton()
///         }
///     }
///
///     final class Presenter {
///         unowned let view: ViewController
///         let router: Router
///
///         init(
///             view: ViewController,
///             router: Router
///         ) {
///             ...
///         }
///
///         func didTapButton() {
///             router.toDestination()
///         }
///     }
///
///     struct Router {
///         let navigator: ViewController
///
///         init(navigator: ViewController) {
///             ...
///         }
///
///         func toDestination() {
///             navigator.push(Destination())
///         }
///     }
///
///     final class Destination: UIViewController {}
///
/// Methods have default implementations for `UIViewControllers`, except for `setRoot(to:)` method.
/// To implement this method, place the following snippet somewhere in the project.
///
///     extension StandardNavigable where Self: UIViewController {
///         func setRoot(to viewController: UIViewController) {
///             SceneDelegate.setRoot(to: viewController)
///         }
///     }
///
///     extension SceneDelegate {
///         fileprivate static func setRoot(to viewController: UIViewController) {
///             shared?.window?.rootViewController = viewController
///         }
///
///         private static var shared: SceneDelegate? {
///             for scene in UIApplication.shared.connectedScenes {
///                 if
///                     let windowScene = scene as? UIWindowScene,
///                     let delegate: UISceneDelegate = windowScene.delegate,
///                     let sceneDelegate = delegate as? SceneDelegate
///                 {
///                     return sceneDelegate
///                 }
///             }
///
///             return nil
///         }
///     }
///
@MainActor
public protocol StandardNavigable {
    /// Pushes a `UIViewController` onto the receiver’s stack and updates the display.
    func push(_ viewController: UIViewController, animated: Bool)
    
    /// Pops the top `UIViewController` from the navigation stack and updates the display.
    func pop(animated: Bool)
    
    /// Pops the given number of top `UIViewController` from navigation stack and updates the display.
    ///
    /// If there are less `UIViewController`'s in the navigation stack, than`count`, methods returns.
    func pop(count: Int, animated: Bool)
    
    /// Pops all the `UIViewController`s on the stack except the root `UIViewController` and updates the display.
    func popToRoot(animated: Bool)
    
    /// Presents a `UIViewController` modally.
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    
    /// Dismisses the `UIViewController` that was presented modally by the `UIViewController`.
    func dismiss(animated: Bool, completion: (() -> Void)?)
    
    /// Sets `UIViewController` as root `UIViewController` and updates the display.
    func setRoot(to viewController: UIViewController)
}

extension StandardNavigable {
    /// Pushes a `UIViewController` onto the receiver’s stack and updates the display.
    public func push(_ viewController: UIViewController) {
        push(viewController, animated: true)
    }
    
    /// Pops the top `UIViewController` from the navigation stack and updates the display.
    public func pop() {
        pop(animated: true)
    }
    
    /// Pops the given number of top `UIViewController` from navigation stack and updates the display.
    ///
    /// If there are less `UIViewController`'s in the navigation stack, than`count`, methods returns.
    public func pop(count: Int) {
        pop(count: count, animated: false)
    }
    
    /// Pops all the `UIViewController`s on the stack except the root `UIViewController` and updates the display.
    public func popToRoot() {
        popToRoot(animated: true)
    }
    
    /// Presents a `UIViewController` modally.
    public func present(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    /// Dismisses the `UIViewController` that was presented modally by the `UIViewController`.
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
    
    public func pop(count: Int, animated: Bool) {
        guard let navigationController else { return }
        
        let viewControllers: [UIViewController] = navigationController.viewControllers
        guard viewControllers.count >= (count + 1) else { return }
        
        navigationController.popToViewController(viewControllers[(viewControllers.count-1) - count], animated: animated)
    }
    
    public func popToRoot(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    public func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        present(viewController, animated: animated, completion: completion)
    }
    
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        dismiss(animated: animated, completion: completion)
    }
}

#endif
