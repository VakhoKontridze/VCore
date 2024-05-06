//  
//  PostsViewModel.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation
import VCore

// MARK: - Posts View Model
@Observable
final class PostsViewModel {
    // MARK: Properties
    @ObservationIgnored private let parameters: PostsParameters

    private(set) var posts: [FetchPostsEntity.Post] = []

    @ObservationIgnored var navigationStackCoordinator: NavigationStackCoordinator!
    var alertParameters: AlertParameters?
    private(set) var progressViewParameters: ProgressViewParameters?

    @ObservationIgnored private var fetchPostsTask: Task<Void, Never>?

    // MARK: Initializers
    init(parameters: PostsParameters) {
        self.parameters = parameters
    }

    deinit {
        fetchPostsTask?.cancel()
    }

    // MARK: Lifecycle
    func didLoad() {
        Task(operation: { await self.fetchPosts() })
    }
    
    // MARK: Actions
    func didPullToRefresh() {
        Task(operation: { await self.fetchPosts() })
    }
    
    func didTapPost(_ post: FetchPostsEntity.Post) {
        navigationStackCoordinator.path.append(PostDetailsParameters(post: post))
    }
    
    // MARK: Requests
    @MainActor
    private func fetchPosts() {
        posts = []
        
        fetchPostsTask?.cancel()
        fetchPostsTask = Task(operation: {
            progressViewParameters = ProgressViewParameters()
            defer { progressViewParameters = nil }

            do {
                let postsEntity: FetchPostsEntity = try await DIContainer.shared.networkGateways.posts.fetch()
                guard !Task.isCancelled else { return }
                
                posts = postsEntity.posts
                
            } catch {
                guard !Task.isCancelled else { return }

                alertParameters = AlertParameters(error: error, completion: nil)
            }
        })
    }
}
