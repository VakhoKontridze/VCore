//  
//  PostsInteractor.swift
//  UIKitViperArchitectureDemo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

// MARK: - Posts Interactor
struct PostsInteractor: PostsInteractive {
    func fetchPosts(completion: @escaping (Result<PostsEntity, Error>) -> Void) {
        PostsNetworkGateway().fetch(completion: completion)
    }
}
