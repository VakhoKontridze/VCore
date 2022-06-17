//  
//  PostsEntity.swift
//  UIKit Viper Demo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

// MARK: - Posts Entity
struct PostsEntity {
    let posts: [Post?]?
}

// MARK: - Post
extension PostsEntity {
    struct Post: Decodable {
        // MARK: Properties
        let id: Int?
        let userID: Int?
        let title: String?
        let body: String?
        
        // MARK: Coding Keys
        private enum CodingKeys: String, CodingKey {
            case id = "id"
            case userID = "userId"
            case title = "title"
            case body = "body"
        }
    }
}
