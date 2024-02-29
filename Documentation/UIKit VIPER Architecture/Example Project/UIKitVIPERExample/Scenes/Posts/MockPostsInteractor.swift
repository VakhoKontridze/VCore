//
//  MockPostsInteractor.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 21.01.24.
//

import Foundation

// MARK: - Mock Posts Interactor
struct MockPostsInteractor: PostsInteractive {
    func fetchPosts(completion: @escaping (Result<FetchPostsEntity, any Error>) -> Void) {
        MockFetchPostsGateway().fetch(completion: completion)
    }
}

