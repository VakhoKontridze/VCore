//  
//  PostsFactory.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit
import VCore

// MARK: - Posts Factory
@Uninitializable
struct PostsFactory {
    static func `default`() -> UIViewController {
        let viewController: PostsViewController = .init()
        
        let router: PostsRouter = .init(navigator: viewController)
        
        let interactor: PostsInteractor = .init()
        
        let presenter: PostsPresenter = .init(
            view: viewController,
            router: router,
            interactor: interactor
        )
        
        viewController.presenter = presenter
        
        return viewController
    }

    static func mock() -> UIViewController {
        let viewController: PostsViewController = .init()

        let router: PostsRouter = .init(navigator: viewController)

        let interactor: MockPostsInteractor = .init()

        let presenter: PostsPresenter = .init(
            view: viewController,
            router: router,
            interactor: interactor
        )

        viewController.presenter = presenter

        return viewController
    }
}
