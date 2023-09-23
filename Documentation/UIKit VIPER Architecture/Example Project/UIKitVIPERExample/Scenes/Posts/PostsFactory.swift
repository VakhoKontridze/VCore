//  
//  PostsFactory.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit

// MARK: - Posts Factory
struct PostsFactory {
    // MARK: Initializers
    private init() {}
    
    // MARK: Factory
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
}
