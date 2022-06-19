//
//  SwiftUIVIPERArchitectureDemoApp.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - App
@main struct SwiftUIVIPArchitectureDemoApp: App {
    var body: some Scene {
        WindowGroup(content: {
            CoordinatingNavigationStack(root: {
                PostsFactory.default()
            })
        })
    }
}
