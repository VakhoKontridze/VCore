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
    @MemberwiseCodable
    struct Post: Decodable {
        @MWCCodingKey("id") let id: Int
        @MWCCodingKey("userId") let userID: Int
        @MWCCodingKey("title") let title: String
        @MWCCodingKey("body") let body: String
    }
}
