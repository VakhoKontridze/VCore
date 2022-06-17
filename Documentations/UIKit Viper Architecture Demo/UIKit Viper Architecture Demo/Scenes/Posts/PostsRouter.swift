//  
//  PostsRouter.swift
//  UIKit Viper Demo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

// MARK: - Posts Router
final class PostsRouter<Navigable>: PostsRoutable
    where Navigable: PostsNavigable
{
    // MARK: Properties
    private unowned let navigable: Navigable

    // MARK: Initializers
    init(
        navigable: Navigable
    ) {
        self.navigable = navigable
    }

    // MARK: Routable
    func toPostDetails(viewModel: PostDetailsViewModel) {
        navigable.push(PostDetailsFactory.default(viewModel: viewModel))
    }
}
