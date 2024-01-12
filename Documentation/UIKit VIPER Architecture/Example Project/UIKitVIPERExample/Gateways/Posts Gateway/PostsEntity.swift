//  
//  PostsEntity.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation
import VCore

// MARK: - Posts Entity
struct PostsEntity {
    // MARK: Properties
    let posts: [Post]

    // MARK: Post
    @CodingKeysGeneration
    struct Post: Decodable {
        @CKGCodingKey("id") let id: Int
        @CKGCodingKey("userId") let userID: Int
        @CKGCodingKey("title") let title: String
        @CKGCodingKey("body") let body: String
    }
}
