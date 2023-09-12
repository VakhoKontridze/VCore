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
    var navigationStackCoordinator: NavigationStackCoordinator!
    @Published var alertParameters: AlertParameters?
    @Published var progressViewParameters: ProgressViewParameters?

    @Published var posts: [Post] = []

    private var fetchPostsTask: Task<Void, Never>?
    
    // MARK: Initializers
    init() {}
    
    // MARK: Methods
    func didLoad() {
        fetchPosts()
    }
    
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
