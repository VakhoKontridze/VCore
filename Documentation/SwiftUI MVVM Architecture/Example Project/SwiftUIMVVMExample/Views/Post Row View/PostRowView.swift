//
//  PostRowView.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI

// MARK: - Post Row View
struct PostRowView: View {
    // MARK: Properties
    private typealias UIModel = PostRowViewUIModel
    
    private let post: PostsEntity.Post

    // MARK: Initializers
    init(post: PostsEntity.Post) {
        self.post = post
    }
    
    // MARK: Body
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: UIModel.spacing,
            content: {
                Text(post.title)
                    .lineLimit(1)
                    .foregroundStyle(UIModel.titleTextColor)
                    .font(UIModel.titleTextFont)

                Text(post.body)
                    .lineLimit(UIModel.bodyTextLineLimit)
                    .foregroundStyle(UIModel.bodyTextColor)
                    .font(UIModel.bodyTextFont)
            }
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(content: { UIModel.backgroundColor })
    }
}

// MARK: - Preview
struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView(
            post: PostsEntity.Post(
                id: 0,
                userID: 0,
                title: "Lorem Ipsum",
                body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam imperdiet augue eget odio posuere pharetra. Donec et vestibulum turpis. Integer consequat sapien ut ligula facilisis, nec aliquet erat aliquet. Praesent sed scelerisque enim. Cras quam nibh, tincidunt non sollicitudin non, egestas in mi. Morbi tempor sit amet ligula nec lacinia. Curabitur malesuada placerat lectus, sed rutrum sapien semper id. Aliquam ac sagittis urna. Nam pharetra nulla et nunc mollis, vel molestie justo consequat. Praesent ac ullamcorper quam. Duis sagittis mauris quam, vel maximus ligula ultrices eu. Proin massa ligula, ornare sit amet convallis sed, tincidunt nec neque."
            )
        )
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .previewLayout(.sizeThatFits)
    }
}
