//  
//  PostDetailsView.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - Post Details View
struct PostDetailsView: View {
    // MARK: Properties
    @StateObject private var viewModel: PostDetailsViewModel

    private typealias UIModel = PostDetailsUIModel

    // MARK: Initializers
    init(parameters: PostDetailsParameters) {
        self._viewModel = StateObject(wrappedValue: PostDetailsViewModel(parameters: parameters))
    }
    
    // MARK: Body
    var body: some View {
        ZStack(content: {
            backgroundView
            contentView
        })
        .inlineNavigationTitle(viewModel.title)
    }
    
    private var backgroundView: some View {
        UIModel.backgroundColor.ignoresSafeArea()
    }
    
    private var contentView: some View {
        ScrollView(content: {
            Text(viewModel.body)
                .foregroundColor(UIModel.bodyTextColor)
                .font(UIModel.bodyTextFont)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(UIModel.bodyTextPadding)
        })
    }
}

// MARK: - Preview
struct PostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatingNavigationStack(root: {
            PostDetailsView(parameters: .mock)
        })
    }
}
