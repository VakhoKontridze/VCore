//
//  FetchPostsGateway.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation
import VCore

// MARK: - Fetch Posts Gateway
struct FetchPostsGateway: FetchPostsGatewayProtocol {
    func fetch() async throws -> FetchPostsEntity {
        let url: URL = #url("https://jsonplaceholder.typicode.com/posts")

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        try request.addHTTPHeaderFields(object: JSONRequestHeaderFields())

        try? await Task.sleep(seconds: 1)

        let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)

        guard response.isSuccessHTTPStatusCode else { throw URLError(.badServerResponse) }

        let posts: [FetchPostsEntity.Post] = try JSONDecoder().decode([FetchPostsEntity.Post].self, from: data)
        let entity: FetchPostsEntity = .init(posts: posts)

        return entity
    }
}
