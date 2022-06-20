//  
//  PostsView.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - Posts Scene View
struct PostsView<Presenter>: View
    where Presenter: PostsPresentable
{
    // MARK: Properties
    @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator?
    @StateObject private var presenter: Presenter
    
    private typealias Model = PostsUIModel
    
    // MARK: Initializers
    init(presenter: Presenter) {
        self._presenter = .init(wrappedValue: presenter) 
    }

    // MARK: Body
    var body: some View {
        ZStack(content: {
            canvas
            contentView
        })
            .onFirstAppear(perform: { presenter.navigationStackCoordinator = navigationStackCoordinator })
            .standardNavigationTitle("Posts")
            .alert(parameters: $presenter.alertParameters)
            .progressView(parameters: presenter.progressViewParameters)
    }
    
    private var canvas: some View {
        Model.Colors.background.ignoresSafeArea()
    }
    
    private var contentView: some View {
        List(content: {
            ForEach(presenter.postParameters, content: { parameters in
                PostRowView(parameters: parameters)
                    .listRowInsets(.init())
                    .onTapGesture(perform: { presenter.toPostDetails(parameters: parameters) })
            })
        })
            .listStyle(.plain)
            .refreshable(action: { presenter.refreshPosts() })
    }
}

// MARK: - Previews
struct PostsViewPostsPreviews: PreviewProvider {
    static var previews: some View {
        CoordinatingNavigationStack(root: {
            PostsFactory.mock()
        })
    }
}
