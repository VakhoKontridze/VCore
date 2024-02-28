//  
//  PostsView.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - Posts View
struct PostsView: View {
    // MARK: Properties
    @State private var viewModel: PostsViewModel

    private typealias UIModel = PostsUIModel

    @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator!

    // MARK: Initializers
    init(parameters: PostsParameters) {
        self._viewModel = State(wrappedValue: PostsViewModel(parameters: parameters))
    }
    
    // MARK: Body
    var body: some View {
        ZStack(content: {
            backgroundView
            contentView
        })
        .onFirstAppear(perform: {
            viewModel.navigationStackCoordinator = navigationStackCoordinator
            viewModel.didLoad()
        })

        .inlineNavigationTitle("Posts")
        .navigationDestination(for: PostDetailsParameters.self, destination: PostDetailsView.init)

        .alert(parameters: $viewModel.alertParameters)
        .progressView(parameters: viewModel.progressViewParameters)
    }
    
    private var backgroundView: some View {
        UIModel.backgroundColor.ignoresSafeArea()
    }
    
    private var contentView: some View {
        List(content: {
            ForEach(viewModel.posts, content: { post in
                PostRowView(post: post)
                    .padding(UIModel.rowPadding)
                    .listRowInsets(EdgeInsets())
                    .onTapGesture(perform: { viewModel.didTapPost(post) })
            })
        })
        .listStyle(.plain)
        .refreshable(action: { viewModel.didPullToRefresh() })
    }
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    DIContainer.current.injectPreview()

    return CoordinatingNavigationStack(root: {
        PostsView(parameters: .mock)
    })
})

#endif
