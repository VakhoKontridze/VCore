//  
//  PostsInteraface.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - Posts Presentable
@MainActor protocol PostsPresentable: ObservableObject {
    /*@Published*/ var navigationStackCoordinator: NavigationStackCoordinator? { get set }
    /*@Published*/ var alertParameters: AlertParameters? { get set }
    /*@Published*/ var progressViewParameters: ProgressViewParameters? { get }
    
    /*@Published*/ var postParameters: [PostRowViewParameters] { get }
    
    func refreshPosts()
    func toPostDetails(parameters: PostRowViewParameters)
}

// MARK: - Posts Routable
protocol PostsRoutable: ViewModifier {}

// MARK: - Posts Interactive
protocol PostsInteractive {
    func fetchPosts() async throws -> PostsEntity
}