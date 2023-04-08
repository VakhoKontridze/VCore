//  
//  PostsRouter.swift
//  UIKitViperArchitectureDemo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

// MARK: - Posts Router
final class PostsRouter<Navigator>: PostsRoutable
    where Navigator: PostsNavigable
{
    // MARK: Properties
    private unowned let navigator: Navigator
    
    // MARK: Initializers
    init(
        navigator: Navigator
    ) {
        self.navigator = navigator
    }
    
    // MARK: Routable
    func toPostDetails(parameters: PostDetailsParameters) {
        navigator.push(PostDetailsFactory.default(parameters: parameters))
    }
}
