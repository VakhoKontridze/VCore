//  
//  PostsInterface.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation
import VCore

// MARK: - Posts Viewable
protocol PostsViewable: AnyObject, UIAlertViewable, UIActivityIndicatorViewable {
    func reloadPosts()
    func setPullToRefreshVisibility(to isVisible: Bool)
}

// MARK: - Posts Navigable
protocol PostsNavigable: AnyObject, StandardNavigable {}

// MARK: - Posts Presentable
protocol PostsPresentable: UITableViewDelegable, UITableViewDataSourceable {
    func viewDidLoad()
    func didPullToRefresh()
}

// MARK: - Posts Routable
protocol PostsRoutable {
    func toPostDetails(parameters: PostDetailsParameters)
}

// MARK: - Posts Interactive
protocol PostsInteractive {
    func fetchPosts(completion: @escaping (Result<PostsEntity, any Error>) -> Void)
}
