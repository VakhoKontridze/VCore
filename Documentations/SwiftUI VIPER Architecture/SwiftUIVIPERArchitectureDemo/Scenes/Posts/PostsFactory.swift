//  
//  PostsFactory.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - Posts Factory
@MainActor struct PostsFactory {
    // MARK: Initalizers
    private init() {}
    
    // MARK: Factory
    static func `default`() -> some View {
        PostsView(
            presenter: PostsPresenter(
                interactor: PostsInteractor()
            )
        )
            .modifier(PostsRouter())
    }
    
    static func mock() -> some View {
        PostsView(
            presenter: PostsPresenter(
                interactor: PostsMockInteractor()
            )
        )
            .modifier(PostsRouter())
    }
}
