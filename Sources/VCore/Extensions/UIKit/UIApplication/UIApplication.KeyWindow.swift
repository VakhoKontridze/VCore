//
//  UIApplication.KeyWindow.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/14/22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Application Key Window
extension UIApplication {
    /// Returns first `UIWindow` in a single-scene application.
    ///
    /// This property assumes, that `supportsMultipleScenes` is `false`.
    ///
    ///     let keyWindow: UIWindow? = UIApplication.shared.firstWindowInSingleSceneApp
    ///
    public var firstWindowInSingleSceneApp: UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first
    }
    
    /// Returns key `UIWindow` in a single-scene application.
    ///
    /// This property assumes, that `supportsMultipleScenes` is `false`.
    ///
    ///     let keyWindow: UIWindow? = UIApplication.shared.keyWindowInSingleSceneApp
    ///
    public var keyWindowInSingleSceneApp: UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: { $0.isKeyWindow })
    }
    
    /// Returns key active `UIWindow` in a single-scene application.
    ///
    /// This property assumes, that `supportsMultipleScenes` is `false`.
    ///
    ///     let keyActiveWindow: UIWindow? = UIApplication.shared.keyActiveWindowInSingleSceneApp
    ///
    public var keyActiveWindowInSingleSceneApp: UIWindow? {
        firstWindow(where: { $0.isKeyWindow })
    }
}

extension UIApplication {
    /// Returns first `UIWindow` from all connected scenes, that satisfies predicate.
    public func firstWindow(
        activationStates: [UIScene.ActivationState] = [.foregroundActive],
        where predicate: (UIWindow) throws -> Bool
    ) rethrows -> UIWindow? {
        try connectedScenes
            .filter { activationStates.contains($0.activationState) }
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: predicate)
    }
}

#endif
