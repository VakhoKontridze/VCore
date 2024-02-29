//
//  PostsNetworkMockGateway.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 21.01.24.
//

import Foundation

// MARK: - Posts Network Mock Gateway
struct PostsNetworkMockGateway: PostsGateway {
    func fetch(completion: @escaping (Result<PostsEntity, any Error>) -> Void) {
        completion(.success(.mock))
    }
}

