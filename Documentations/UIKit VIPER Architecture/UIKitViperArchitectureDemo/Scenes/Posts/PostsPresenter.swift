//  
//  PostsPresenter.swift
//  UIKitViperArchitectureDemo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation
import VCore

// MARK: - Posts Presenter
final class PostsPresenter<View, Router, Interactor>: PostsPresentable
    where
        View: PostsViewable,
        Router: PostsRoutable,
        Interactor: PostsInteractive
{
    // MARK: Properties
    private unowned let view: View
    private let router: Router
    private let interactor: Interactor
    
    private var tableViewCellParameters: [PostCellViewParameters] = []
    
    private let sessionManager: SessionManager = .init()

    // MARK: Initializers
    init(
        view: View,
        router: Router,
        interactor: Interactor
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    // MARK: Presentable
    func viewDidLoad() {
        fetchPosts()
    }
    
    func didPullToRefresh() {
        fetchPosts()
        view.setPullToRefreshVisibility(to: false)
    }

    // MARK: Table View Delegatable
    func tableViewDidSelectRow(section: Int, row: Int) {
        let postCellViewModel: PostCellViewParameters = tableViewCellParameters[row]
        
        router.toPostDetails(parameters: .init(
            title: postCellViewModel.title,
            body: postCellViewModel.body
        ))
    }

    // MARK: Table View DataSourceable
    var tableViewNumberOfSections: Int {
        1
    }
    
    func tableViewNumberOfRows(section: Int) -> Int {
        tableViewCellParameters.count
    }
    
    func tableViewCellParameter(section: Int, row: Int) -> any UITableViewCellParameter {
        tableViewCellParameters[row]
    }
    
    // MARK: Requests
    private func fetchPosts() {
        let sessionID: Int = sessionManager.newSessionID
        
        tableViewCellParameters = []
        view.reloadPosts()
        
        view.startActivityIndicatorAnimation()
        interactor.fetchPosts(completion: { [weak self] result in
            guard let self = self else { return }
            
            self.view.stopActivityIndicatorAnimation()
            
            guard self.sessionManager.sessionIsValid(id: sessionID) else { return }
            
            switch result {
            case .success(let postsEntity):
                self.tableViewCellParameters = postsEntity.posts?.compactMap { $0 }.compactMap { .init(post: $0) } ?? []
                self.view.reloadPosts()
                
            case .failure(let error):
                self.view.presentAlert(parameters: .init(error: error, completion: nil))
            }
        })
    }
}
