//  
//  PostsNetworkGateway.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation
import VCore

// MARK: - Posts Network Gateway
struct PostsNetworkGateway: PostsGateway {
    func fetch() async throws -> PostsEntity {
        let url: URL = #url("https://jsonplaceholder.typicode.com/posts")

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        try request.addHTTPHeaderFields(object: JSONRequestHeaderFields())

        try? await Task.sleep(seconds: 1)

        let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)

        guard response.isSuccessHTTPStatusCode else { throw URLError(.badServerResponse) }

        let posts: [PostsEntity.Post] = try JSONDecoder().decode([PostsEntity.Post].self, from: data)
        let entity: PostsEntity = .init(posts: posts)

        return entity
    }
}
