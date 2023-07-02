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
        VStack(alignment: .leading, spacing: UIModel.spacing, content: {
            Text(parameters.title)
                .lineLimit(1)
                .foregroundColor(UIModel.titleTextColor)
                .font(UIModel.titleTextFont)
            
            Text(parameters.body)
                .lineLimit(UIModel.bodyTextLineLimit)
                .foregroundColor(UIModel.bodyTextColor)
                .font(UIModel.bodyTextFont)
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(UIModel.padding)
        .background(content: { UIModel.backgroundColor.ignoresSafeArea() })
    }
}

// MARK: - Preview
struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView(parameters: .mock)
            .previewLayout(.sizeThatFits)
    }
}
