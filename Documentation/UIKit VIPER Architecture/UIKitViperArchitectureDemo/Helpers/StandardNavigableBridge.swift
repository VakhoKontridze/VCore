//
//  StandardNavigableBridge.swift
//  UIKitViperArchitectureDemo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit
import VCore

// MARK: - Standard Navigable Bridge
extension StandardNavigable where Self: UIViewController {
    func setRoot(to viewController: UIViewController) {
        SceneDelegate.setRoot(to: viewController)
    }
}

extension SceneDelegate {
    static func setRoot(to viewController: UIViewController) {
        guard
            let windowScene: UIWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate: SceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }

        sceneDelegate.window?.rootViewController = viewController
    }
}
