//  
//  PostsView.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - Posts View
struct PostsView<Presenter>: View
    where Presenter: PostsPresentable
{
    // MARK: Properties
    @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator?
    @StateObject private var presenter: Presenter
    
    private typealias Model = PostsUIModel
    
    @State private var didAppearForTheFirstTime: Bool = false
    
    // MARK: Initializers
    init(
        presenter: @escaping @autoclosure () -> Presenter
    ) {
        self._presenter = StateObject(wrappedValue: presenter())
    }
    
    // MARK: Body
    var body: some View {
        ZStack(content: {
            canvas
            contentView
        })
        .onFirstAppear($didAppearForTheFirstTime, perform: {
            presenter.navigationStackCoordinator = navigationStackCoordinator
            presenter.didLoad()
        })
        .inlineNavigationTitle("Posts")
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
                    .listRowInsets(EdgeInsets())
                    .onTapGesture(perform: { presenter.didTapPost(parameters: parameters) })
            })
        })
        .listStyle(.plain)
        .refreshable(action: { presenter.didPullToRefresh() })
    }
}

// MARK: - Preview
struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatingNavigationStack(root: {
            PostsFactory.mock()
        })
    }
}
