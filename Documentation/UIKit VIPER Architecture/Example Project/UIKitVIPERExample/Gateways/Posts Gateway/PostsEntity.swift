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
        @MWCKey("id") let id: Int
        @MWCKey("userId") let userID: Int
        @MWCKey("title") let title: String
        @MWCKey("body") let body: String
    }
}
