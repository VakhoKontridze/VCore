//  
//  PostsNetworkGateway.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation
import VCore

// MARK: - Posts Network Gateway
struct PostsNetworkGateway: PostsGateway {
    func fetch() async throws -> PostsEntity {
        var request: NetworkRequest = .init(url: "https://jsonplaceholder.typicode.com/posts")
        request.method = .GET
        
        try? await Task.sleep(seconds: 1)
        
        let posts: [PostsEntity.Post] = try await NetworkClient.default.decodable(from: request)
        let entity: PostsEntity = .init(posts: posts)
        
        return entity
    }
}
