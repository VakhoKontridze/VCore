//
//  PostsMockInteractor.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 21.01.24.
//

import Foundation

// MARK: - Posts Mock Interactor
struct PostsMockInteractor: PostsInteractive {
    func fetchPosts(completion: @escaping (Result<PostsEntity, any Error>) -> Void) {
        PostsMockGateway().fetch(completion: completion)
    }
}

