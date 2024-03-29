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
    @State private var viewModel: PostDetailsViewModel

    private typealias UIModel = PostDetailsUIModel

    // MARK: Initializers
    init(parameters: PostDetailsParameters) {
        self._viewModel = State(wrappedValue: PostDetailsViewModel(parameters: parameters))
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
                .foregroundStyle(UIModel.bodyTextColor)
                .font(UIModel.bodyTextFont)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(UIModel.bodyTextPadding)
        })
    }
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    DIContainer.current.injectPreviewDependencies()

    return CoordinatingNavigationStack(root: {
        PostDetailsView(parameters: .mock)
    })
})

#endif
