//
//  AppDelegate.swift
//  VCoreDemo
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import UIKit

// MARK:- App Delegate
@main final class AppDelegate: UIResponder {}

// MARK:- App Delegate
extension AppDelegate: UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        true
    }
}

// MARK:- Scene Delegate
extension AppDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        .init(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
