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
    
    private let post: Post
    
    // MARK: Initializers
    init(post: Post) {
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
        PostRowView(post: .mock)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .previewLayout(.sizeThatFits)
    }
}
