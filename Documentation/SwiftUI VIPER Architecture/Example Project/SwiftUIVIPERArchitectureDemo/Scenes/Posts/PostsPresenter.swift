//  
//  PostsPresenter.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation
import VCore

// MARK: - Posts Presenter
@MainActor final class PostsPresenter<Interactor>: PostsPresentable
    where Interactor: PostsInteractive
{
    // MARK: Properties
    private let interactor: Interactor
    
    private var fetchPostsTask: Task<Void, Never>?
    
    // MARK: Initializers
    nonisolated init(interactor: Interactor) {
        self.interactor = interactor
    }
    
    // MARK: Presentable
    @Published var didAppearForTheFirstTime: Bool = false
    
    @Published var posts: [Post] = []
    
    func didLoad() {
        fetchPosts()
    }
    
    func didPullToRefresh() {
        fetchPosts()
    }
    
    func didTapPost(_ post: Post) {
        navigationStackCoordinator?.path.append(PostDetailsParameters(post: post))
    }

    // MARK: Navigation Stack Coordinable
    var navigationStackCoordinator: NavigationStackCoordinator?

    // MARK: Alert Presentable
    @Published var alertParameters: AlertParameters?

    // MARK: Progress View Presentable
    @Published var progressViewParameters: ProgressViewParameters?
    
    // MARK: Requests
    private func fetchPosts() {
        guard NetworkReachabilityService.shared.isConnectedToNetwork != false else {
            alertParameters = AlertParameters(error: URLError(.notConnectedToInternet), completion: nil)
            return
        }

        posts = []
        progressViewParameters = ProgressViewParameters(isInteractionEnabled: false)
        
        fetchPostsTask?.cancel()
        fetchPostsTask = Task(operation: {
            do {
                let postsEntity: PostsEntity = try await interactor.fetchPosts()
                progressViewParameters = nil
                guard !Task.isCancelled else { return }
                
                posts = postsEntity.posts?
                    .compactMap { $0 }
                    .compactMap { Post(entity: $0) } ??
                    []
                
            } catch {
                progressViewParameters = nil
                alertParameters = AlertParameters(error: error, completion: nil)
            }
        })
    }
}

// MARK: - Mapping
extension Post {
    fileprivate init?(entity: PostsEntity.Post) {
        guard
            let id: Int = entity.id,
            let title: String = entity.title,
            let body: String = entity.body
        else {
            return nil
        }

        self.init(
            id: id,
            title: title.capitalized,
            body: body
        )
    }
}
