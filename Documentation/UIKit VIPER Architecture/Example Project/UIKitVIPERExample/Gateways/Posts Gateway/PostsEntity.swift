//  
//  FetchPostsEntity.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation
import VCore

// MARK: - Fetch Posts Entity
struct FetchPostsEntity {
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

    // MARK: Mock
#if DEBUG
    static var mock: Self {
        .init(
            posts: (0..<20).map { i in
                FetchPostsEntity.Post(
                    id: i,
                    userID: Int.random(in: 1...10),
                    title: "Lorem Ipsum",
                    body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam imperdiet augue eget odio posuere pharetra. Donec et vestibulum turpis. Integer consequat sapien ut ligula facilisis, nec aliquet erat aliquet. Praesent sed scelerisque enim. Cras quam nibh, tincidunt non sollicitudin non, egestas in mi. Morbi tempor sit amet ligula nec lacinia. Curabitur malesuada placerat lectus, sed rutrum sapien semper id. Aliquam ac sagittis urna. Nam pharetra nulla et nunc mollis, vel molestie justo consequat. Praesent ac ullamcorper quam. Duis sagittis mauris quam, vel maximus ligula ultrices eu. Proin massa ligula, ornare sit amet convallis sed, tincidunt nec neque."
                )
            }
        )
    }
#endif
}
