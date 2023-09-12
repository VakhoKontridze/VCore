//
//  SwiftUIMVVMExample.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - App
@main struct SwiftUIMVVMExample: App {
    // MARK: Initializers
    init() {
        DIContainer.current.injectDefault()
    }

    // MARK: Body
    var body: some Scene {
        WindowGroup(content: {
            CoordinatingNavigationStack(root: {
                PostsView()
            })
        })
    }
}
