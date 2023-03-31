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
    
    var navigationStackCoordinator: NavigationStackCoordinator?
    @Published var alertParameters: AlertParameters?
    @Published var progressViewParameters: ProgressViewParameters?
    
    @Published var postParameters: [PostRowViewParameters] = []
    
    func didLoad() {
        fetchPosts()
    }
    
    func didPullToRefresh() {
        fetchPosts()
    }
    
    func didTapPost(parameters: PostRowViewParameters) {
        navigationStackCoordinator?.path.append(PostDetailsParameters(
            title: parameters.title,
            body: parameters.body
        ))
    }
    
    // MARK: Requests
    private func fetchPosts() {
        postParameters = []
        progressViewParameters = ProgressViewParameters(isInteractionEnabled: false)
        
        fetchPostsTask?.cancel()
        fetchPostsTask = Task(operation: {
            do {
                let postsEntity: PostsEntity = try await interactor.fetchPosts()
                progressViewParameters = nil
                guard !Task.isCancelled else { return }
                
                postParameters = postsEntity.posts?.compactMap { $0 }.compactMap { PostRowViewParameters(post: $0) } ?? []
            
            } catch {
                progressViewParameters = nil
                alertParameters = AlertParameters(error: error, completion: nil)
            }
        })
    }
}
