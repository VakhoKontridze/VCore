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
    @StateObject private var viewModel: PostsViewModel

    private typealias UIModel = PostsUIModel

    @Environment(\.navigationStackCoordinatorOO) private var navigationStackCoordinator: NavigationStackCoordinatorOO!
    
    @State private var didAppearForTheFirstTime: Bool = false

    // MARK: Initializers
    init() {
        self._viewModel = StateObject(wrappedValue: PostsViewModel())
    }
    
    // MARK: Body
    var body: some View {
        ZStack(content: {
            backgroundView
            contentView
        })
        .onFirstAppear($didAppearForTheFirstTime, perform: {
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
struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatingNavigationStackOO(root: {
            PostsView()
        })
    }
}
