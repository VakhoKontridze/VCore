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
        guard let window: UIWindow = view.window else { return }

        window.rootViewController = viewController
    }
}
