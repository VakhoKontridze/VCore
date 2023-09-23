//  
//  PostsViewModel.swift
//  UIKitVIPERExample
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
    
    private var tableViewCellParameters: [PostCellParameters] = []
    
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
        view.setPullToRefreshVisibility(to: false)
        fetchPosts()
    }
    
    // MARK: Table View Delegable
    func tableViewDidSelectRow(section: Int, row: Int) {
        let postCellParameters: PostCellParameters = tableViewCellParameters[row]

        router.toPostDetails(parameters: PostDetailsParameters(
            post: postCellParameters.post
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
        guard NetworkReachabilityService.shared.isConnectedToNetwork != false else {
            view.presentAlert(parameters: UIAlertParameters(error: URLError(.notConnectedToInternet), completion: nil))
            return
        }

        tableViewCellParameters = []
        view.reloadPosts()
        
        view.startActivityIndicatorAnimation()
        interactor.fetchPosts(completion: { [weak self] result in
            guard let self else { return }
            
            view.stopActivityIndicatorAnimation()
            
            switch result {
            case .success(let postsEntity):
                tableViewCellParameters = postsEntity.posts?
                    .compactMap { $0 }
                    .compactMap { Post(entity: $0) }
                    .map { PostCellParameters(post: $0) } ??
                    []
                
                view.reloadPosts()
                
            case .failure(let error):
                view.presentAlert(parameters: UIAlertParameters(error: error, completion: nil))
            }
        })
    }
}
