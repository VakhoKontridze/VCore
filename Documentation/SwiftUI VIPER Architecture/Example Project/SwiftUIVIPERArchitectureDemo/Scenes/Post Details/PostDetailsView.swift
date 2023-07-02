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
        .inlineNavigationTitle(presenter.title)
    }
    
    private var canvas: some View {
        UIModel.backgroundColor.ignoresSafeArea()
    }
    
    private var contentView: some View {
        ScrollView(content: {
            Text(presenter.body)
                .padding(UIModel.bodyTextPadding)
                .foregroundColor(UIModel.bodyTextColor)
                .font(UIModel.bodyTextFont)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

// MARK: - Preview
struct PostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatingNavigationStack(
            path: NavigationPath([PostDetailsParameters.mock]),
            root: { PostsFactory.mock() }
        )
    }
}
