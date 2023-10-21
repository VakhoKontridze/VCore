//  
//  PostDetailsParameters.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation

// MARK: - Post Details Parameters
struct PostDetailsParameters: Hashable {
    // MARK: Properties
    let post: PostsEntity.Post

    // MARK: Mock
    static var mock: Self {
        .init(
            post: PostsEntity.Post(
                id: 0,
                userID: 0,
                title: "Lorem Ipsum",
                body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam imperdiet augue eget odio posuere pharetra. Donec et vestibulum turpis. Integer consequat sapien ut ligula facilisis, nec aliquet erat aliquet. Praesent sed scelerisque enim. Cras quam nibh, tincidunt non sollicitudin non, egestas in mi. Morbi tempor sit amet ligula nec lacinia. Curabitur malesuada placerat lectus, sed rutrum sapien semper id. Aliquam ac sagittis urna. Nam pharetra nulla et nunc mollis, vel molestie justo consequat. Praesent ac ullamcorper quam. Duis sagittis mauris quam, vel maximus ligula ultrices eu. Proin massa ligula, ornare sit amet convallis sed, tincidunt nec neque."
            )
        )
    }
}
