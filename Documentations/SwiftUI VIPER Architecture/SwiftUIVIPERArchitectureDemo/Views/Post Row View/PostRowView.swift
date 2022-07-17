//
//  PostRowView.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI

// MARK: - Post Row View
struct PostRowView: View {
    // MARK: Properties
    private typealias UIModel = PostRowViewUIModel
    
    private let parameters: PostRowViewParameters
    
    // MARK: Initializers
    init(parameters: PostRowViewParameters) {
        self.parameters = parameters
    }
    
    // MARK: Body
    var body: some View {
        VStack(alignment: .leading, spacing: UIModel.Layout.spacing, content: {
            Text(parameters.title)
                .lineLimit(1)
                .foregroundColor(UIModel.Colors.titleText)
                .font(UIModel.Fonts.titleText)
            
            Text(parameters.body)
                .lineLimit(UIModel.Layout.bodyTextLineLimit)
                .foregroundColor(UIModel.Colors.bodyText)
                .font(UIModel.Fonts.bodyText)
        })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(UIModel.Layout.padding)
            .background(UIModel.Colors.background.ignoresSafeArea())
    }
}

// MARK: - Preview
struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostsViewPostsPreviews.previews
    }
}
