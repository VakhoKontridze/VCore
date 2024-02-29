//  
//  PostsInteractor.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

// MARK: - Posts Interactor
struct PostsInteractor: PostsInteractive {
    func fetchPosts(completion: @escaping (Result<FetchPostsEntity, any Error>) -> Void) {
        FetchPostsGateway().fetch(completion: completion)
    }
}
