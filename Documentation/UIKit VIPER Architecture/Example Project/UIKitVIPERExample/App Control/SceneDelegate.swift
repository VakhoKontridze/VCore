//
//  SceneDelegate.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit

// MARK: - Scene Delegate
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: Properties
    var window: UIWindow?
    
    // MARK: Window Scene Delegate
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene: UIWindowScene = scene as? UIWindowScene else { return }
        
        let window: UIWindow = .init(windowScene: windowScene); self.window = window
        window.rootViewController = UINavigationController(rootViewController: PostsFactory.default())
        window.makeKeyAndVisible()
    }
}
