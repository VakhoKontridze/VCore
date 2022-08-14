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
    /*@Published*/ var postParameters: [PostRowViewParameters] { get }
    
    func didLoad()
    
    func didPullToRefresh()
    func toPostDetails(parameters: PostRowViewParameters)
}

// MARK: - Posts Routable
protocol PostsRoutable: ViewModifier {}

// MARK: - Posts Interactive
protocol PostsInteractive {
    func fetchPosts() async throws -> PostsEntity
}
