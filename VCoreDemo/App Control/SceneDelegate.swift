//
//  SceneDelegate.swift
//  VCoreDemo
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import UIKit

// MARK:- Scene Delegate
final class SceneDelegate: UIResponder {
    // MARK: Propeties
    var window: UIWindow?
}

// MARK:- Delegate
extension SceneDelegate: UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = .init(windowScene: windowScene)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }
}
