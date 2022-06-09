//
//  SceneDelegate.swift
//  VCoreDemo
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import UIKit
import SwiftUI

// MARK: - Scene Delegate
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: Propeties
    var window: UIWindow?

    // MARK: Window Scene Delegate
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene: UIWindowScene = scene as? UIWindowScene else { return }
        
        window = .init(windowScene: windowScene)
        window?.rootViewController = ViewController()
        //window?.rootViewController = UIHostingController(rootView: ContentView())
        window?.makeKeyAndVisible()
    }
}
