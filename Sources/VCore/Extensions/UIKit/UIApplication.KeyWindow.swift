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
    /// Returns key `UIWindow` in a single-scene application.
    ///
    /// This property assumes, that `supportsMultipleScenes` is `false`, and no `assert` is made.
    ///
    ///     let keyWindow: UIWindow? = UIApplication.shared.keyWindowInSingleSceneApplication
    ///
    public var keyWindowInSingleSceneApplication: UIWindow? {
        firstWindow(where: { $0.isKeyWindow })
    }
    
    /// Returns first `UIWindow` from all connected scenes, that satisfies predicate.
    public func firstWindow(
        activationStates: [UIScene.ActivationState] = [.foregroundActive],
        where predicate: (UIWindow) -> Bool
    ) -> UIWindow? {
        connectedScenes
            .filter { activationStates.contains($0.activationState) }
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: predicate)
    }
}

#endif
