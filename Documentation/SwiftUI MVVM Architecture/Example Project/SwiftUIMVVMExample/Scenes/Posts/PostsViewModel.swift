//  
//  PostsViewModel.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation
import VCore

// MARK: - Posts View Model
@MainActor final class PostsViewModel: ObservableObject {
    // MARK: Properties
    @Published private(set) var posts: [Post] = []

    var navigationStackCoordinator: NavigationStackCoordinator!
    @Published var alertParameters: AlertParameters?
    @Published private(set) var progressViewParameters: ProgressViewParameters?

    private var fetchPostsTask: Task<Void, Never>?
    
    // MARK: Initializers
    init() {}
    
    // MARK: Lifecycle
    func didLoad() {
        fetchPosts()
    }
    
    // MARK: Actions
    func didPullToRefresh() {
        fetchPosts()
    }
    
    func didTapPost(_ post: Post) {
        navigationStackCoordinator.path.append(PostDetailsParameters(post: post))
    }
    
    // MARK: Requests
    private func fetchPosts() {
        posts = []

        progressViewParameters = ProgressViewParameters()
        
        fetchPostsTask?.cancel()
        fetchPostsTask = Task(operation: {
            do {
                let postsEntity: PostsEntity = try await DIContainer.current.postsGateway.fetch()
                guard !Task.isCancelled else { return }

                progressViewParameters = nil
                
                posts = postsEntity.posts?
                    .compactMap { $0 }
                    .compactMap { Post(entity: $0) } ??
                    []
                
            } catch {
                guard !Task.isCancelled else { return }

                progressViewParameters = nil
                alertParameters = AlertParameters(error: error, completion: nil)
            }
        })
    }
}
