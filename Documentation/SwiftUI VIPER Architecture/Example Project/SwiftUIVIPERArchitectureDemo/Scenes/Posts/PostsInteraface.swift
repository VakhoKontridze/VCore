//  
//  PostsInteraface.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - Posts Presentable
@MainActor protocol PostsPresentable: ObservableObject, NavigationStackCoordinable, AlertPresentable, ProgressViewPresentable {
    var posts: [Post] { get }
    
    func didLoad()
    
    func didPullToRefresh()
    func didTapPost(_ post: Post)
}

// MARK: - Posts Routable
protocol PostsRoutable: ViewModifier {}

// MARK: - Posts Interactive
protocol PostsInteractive {
    func fetchPosts() async throws -> PostsEntity
}
