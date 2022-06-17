//  
//  PostsPresenter.swift
//  UIKit Viper Demo
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
    
    private var tableViewCellViewModels: [PostCellViewModel] = []

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
        let postCellViewModel: PostCellViewModel = tableViewCellViewModels[row]
        
        router.toPostDetails(viewModel: .init(
            title: postCellViewModel.title,
            body: postCellViewModel.body
        ))
    }

    // MARK: Table View DataSourceable
    var tableViewNumberOfSections: Int {
        1
    }
    
    func tableViewNumberOfRows(section: Int) -> Int {
        tableViewCellViewModels.count
    }
    
    func tableViewCellViewModel(section: Int, row: Int) -> any UITableViewCellViewModelable {
        tableViewCellViewModels[row]
    }
    
    // MARK: Requests
    private func fetchPosts() {
        tableViewCellViewModels = []
        view.reloadPosts()
        
        view.startActivityIndicatorAnimation()
        interactor.fetchPosts(completion: { [weak self] result in
            guard let self = self else { return }
            
            self.view.stopActivityIndicatorAnimation()
            
            switch result {
            case .success(let postsEntity):
                self.tableViewCellViewModels = postsEntity.posts?.compactMap { $0 }.compactMap { .init(post: $0) } ?? []
                self.view.reloadPosts()
                
            case .failure(let error):
                self.view.presentAlert(viewModel: .init(error: error, completion: nil))
            }
        })
    }
}
