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
    
    // MARK: Initialzers
    init(interactor: Interactor) {
        self.interactor = interactor
        
        fetchPosts()
    }

    // MARK: Presentable
    @Published var navigationStackCoordinator: NavigationStackCoordinator?
    @Published var alertParameters: AlertParameters?
    @Published var progressViewParameters: ProgressViewParameters?
    
    @Published var postParameters: [PostRowViewParameters] = []
    
    func refreshPosts() {
        fetchPosts()
    }
    
    func toPostDetails(parameters: PostRowViewParameters) {
        navigationStackCoordinator?.path.append(PostDetailsParameters(
            title: parameters.title,
            body: parameters.body
        ))
    }
    
    // MARK: Requests
    private func fetchPosts() {
        postParameters = []
        progressViewParameters = .init()
        
        Task(operation: {
            do {
                let postsEntity: PostsEntity = try await interactor.fetchPosts()
                progressViewParameters = nil
                guard !Task.isCancelled else { return }
                
                postParameters = postsEntity.posts?.compactMap { $0 }.compactMap { .init(post: $0) } ?? []
            
            } catch {
                alertParameters = .init(error: error, completion: nil)
                progressViewParameters = nil
            }
        })
    }
}