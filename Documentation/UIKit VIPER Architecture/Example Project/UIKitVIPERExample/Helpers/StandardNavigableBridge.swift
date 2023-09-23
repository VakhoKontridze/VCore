//
//  StandardNavigableBridge.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit
import VCore

// MARK: - Standard Navigable
extension StandardNavigable where Self: UIViewController {
    func setRoot(to viewController: UIViewController) {
        SceneDelegate.setRoot(to: viewController)
    }
}

extension SceneDelegate {
    fileprivate static func setRoot(to viewController: UIViewController) {
        shared?.window?.rootViewController = viewController
    }

    private static var shared: SceneDelegate? {
        for scene in UIApplication.shared.connectedScenes {
            if
                let windowScene = scene as? UIWindowScene,
                let delegate: UISceneDelegate = windowScene.delegate,
                let sceneDelegate = delegate as? SceneDelegate
            {
                return sceneDelegate
            }
        }

        return nil
    }
}
