//  
//  PostDetailsView.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - Post Details View
struct PostDetailsView<Presenter>: View
    where Presenter: PostDetailsPresentable
{
    // MARK: Properties
    @StateObject private var presenter: Presenter
    
    private typealias UIModel = PostDetailsUIModel
    
    // MARK: Initializers
    init(presenter: @escaping @autoclosure () -> Presenter) {
        self._presenter = .init(wrappedValue: presenter())
    }

    // MARK: Body
    var body: some View {
        ZStack(content: {
            canvas
            contentView
        })
            .standardNavigationTitle(presenter.title)
    }
    
    private var canvas: some View {
        UIModel.Colors.background.ignoresSafeArea()
    }
    
    private var contentView: some View {
        ScrollView(content: {
            Text(presenter.body)
                .padding(UIModel.Layout.bodyTextPadding)
                .foregroundColor(UIModel.Colors.bodyText)
                .font(UIModel.Fonts.bodyText)
        })
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

// MARK: - Preview
struct PostDetailsViewPostDetailsPreviews: PreviewProvider {
    static var previews: some View {
        CoordinatingNavigationStack(
            path: .init([PostDetailsParameters.mock]),
            root: { PostsFactory.mock() }
        )
    }
}
