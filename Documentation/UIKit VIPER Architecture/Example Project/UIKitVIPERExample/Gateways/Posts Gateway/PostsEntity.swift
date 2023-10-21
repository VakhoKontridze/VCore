//  
//  PostsEntity.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

// MARK: - Posts Entity
struct PostsEntity {
    // MARK: Posts
    let posts: [Post]

    // MARK: Post
    struct Post: Decodable {
        // MARK: Properties
        let id: Int
        let userID: Int
        let title: String
        let body: String

        // MARK: Coding Keys
        private enum CodingKeys: String, CodingKey {
            case id = "id"
            case userID = "userId"
            case title = "title"
            case body = "body"
        }
    }
}
