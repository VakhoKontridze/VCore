//
//  UIApplication.FirstWindow.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/14/22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Application First Window
extension UIApplication {
    /// Returns first `UIWindow` from all connected scenes that satisfies predicate.
    public func firstWindow(
        activationStates: [UIScene.ActivationState],
        where predicate: (UIWindow) throws -> Bool
    ) rethrows -> UIWindow? {
        try connectedScenes
            .filter { activationStates.contains($0.activationState) }
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: predicate)
    }

    /// Returns first `UIWindow` in a single-scene application.
    ///
    /// This property assumes, that `supportsMultipleScenes` is `false`.
    ///
    ///     let window: UIWindow? = UIApplication.shared.firstWindowInSingleSceneApp
    ///
    public var firstWindowInSingleSceneApp: UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first
    }
    
    /// Returns first key `UIWindow` in a single-scene application.
    ///
    /// This property assumes, that `supportsMultipleScenes` is `false`.
    ///
    ///     let window: UIWindow? = UIApplication.shared.firstKeyWindowInSingleSceneApp
    ///
    public var firstKeyWindowInSingleSceneApp: UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
    /// Returns key active `UIWindow` in a single-scene application.
    ///
    /// This property assumes, that `supportsMultipleScenes` is `false`.
    ///
    ///     let window: UIWindow? = UIApplication.shared.firstKeyActiveWindowInSingleSceneApp
    ///
    public var firstKeyActiveWindowInSingleSceneApp: UIWindow? {
        firstWindow(
            activationStates: [.foregroundActive],
            where: { $0.isKeyWindow }
        )
    }
}

#endif
