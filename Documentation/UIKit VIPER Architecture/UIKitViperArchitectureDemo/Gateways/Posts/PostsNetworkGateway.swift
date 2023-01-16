//  
//  PostsNetworkGateway.swift
//  UIKitViperArchitectureDemo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation
import VCore

// MARK: - Posts Network Gateway
struct PostsNetworkGateway: PostsGateway {
    func fetch(completion: @escaping (Result<PostsEntity, any Error>) -> Void) {
        var request: NetworkRequest = .init(url: "https://jsonplaceholder.typicode.com/posts")
        request.method = .GET
        
        NetworkClient.default.decodable(
            [PostsEntity.Post].self,
            from: request,
            completion: { result in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    switch result {
                    case .success(let posts):
                        let entity: PostsEntity = .init(posts: posts)
                        completion(.success(entity))

                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
            }
        )
    }
}
