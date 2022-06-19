//
//  PostsRouter.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - Posts Router
struct PostsRouter: PostsRoutable {
    // MARK: Properties
    @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator
    
    // MARK: Body
    func body(content: Content) -> some View {
        content
            .navigationDestination(
                for: PostDetailsParameters.self,
                destination: { PostDetailsFactory.default(parameters: $0) }
            )
    }
}
