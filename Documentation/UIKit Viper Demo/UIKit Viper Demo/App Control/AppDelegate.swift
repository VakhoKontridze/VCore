//
//  AppDelegate.swift
//  UIKit Viper Demo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit

// MARK: - App Delegate
@main final class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Application Delegate
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    -> Bool {
        true
    }
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        .init(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }
}
