//  
//  PostsViewModel.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation
import VCore

// MARK: - Posts View Model
@MainActor
final class PostsViewModel: ObservableObject {
    // MARK: Properties
    @Published private(set) var posts: [PostsEntity.Post] = []

    var navigationStackCoordinator: NavigationStackCoordinatorOO!
    @Published var alertParameters: AlertParameters?
    @Published private(set) var progressViewParameters: ProgressViewParameters?

    private var fetchPostsTask: Task<Void, Never>?
    
    // MARK: Initializers
    init() {}

    deinit {
        fetchPostsTask?.cancel()
    }

    // MARK: Lifecycle
    func didLoad() {
        fetchPosts()
    }
    
    // MARK: Actions
    func didPullToRefresh() {
        fetchPosts()
    }
    
    func didTapPost(_ post: PostsEntity.Post) {
        navigationStackCoordinator.path.append(PostDetailsParameters(post: post))
    }
    
    // MARK: Requests
    private func fetchPosts() {
        posts = []
        
        fetchPostsTask?.cancel()
        fetchPostsTask = Task(operation: {
            progressViewParameters = ProgressViewParameters()
            defer { progressViewParameters = nil }

            do {
                let postsEntity: PostsEntity = try await DIContainer.current.gateways.posts.fetch()
                guard !Task.isCancelled else { return }
                
                posts = postsEntity.posts
                
            } catch {
                guard !Task.isCancelled else { return }

                alertParameters = AlertParameters(error: error, completion: nil)
            }
        })
    }
}
