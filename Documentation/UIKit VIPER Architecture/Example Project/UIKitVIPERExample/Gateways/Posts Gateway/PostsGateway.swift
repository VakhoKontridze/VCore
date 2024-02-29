//  
//  Fetch PostsGateway.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation
import VCore

// MARK: - Fetch Posts Gateway
struct FetchPostsGateway: FetchPostsGatewayProtocol {
    func fetch(completion: @escaping (Result<FetchPostsEntity, any Error>) -> Void) {
        let url: URL = #url("https://jsonplaceholder.typicode.com/posts")

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        do {
            try request.addHTTPHeaderFields(object: JSONRequestHeaderFields())
        } catch {
            completion(.failure(error))
            return
        }

        let dataTask: URLSessionDataTask = URLSession.shared.dataTask(
            with: request,
            completionHandler: { (data, response, error) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    if let error {
                        completion(.failure(error))
                        return
                    }

                    guard
                        let response,
                        response.isSuccessHTTPStatusCode
                    else {
                        completion(.failure(URLError(.badServerResponse)))
                        return
                    }

                    guard let data else {
                        completion(.failure(URLError(.cannotDecodeContentData)))
                        return
                    }

                    let posts: [FetchPostsEntity.Post]
                    do {
                        posts = try JSONDecoder().decode([FetchPostsEntity.Post].self, from: data)
                    } catch {
                        completion(.failure(error))
                        return
                    }

                    let entity: FetchPostsEntity = .init(posts: posts)

                    completion(.success(entity))
                })
            }
        )

        dataTask.resume()
    }
}
