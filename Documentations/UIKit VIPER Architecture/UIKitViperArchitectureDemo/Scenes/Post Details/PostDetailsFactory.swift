//  
//  PostDetailsFactory.swift
//  UIKitViperArchitectureDemo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit

// MARK: - Post Details Factory
struct PostDetailsFactory {
    // MARK: Initalizers
    private init() {}
    
    // MARK: Factory
    static func `default`(parameters: PostDetailsParameters) -> UIViewController {
        let viewController: PostDetailsViewController = .init()

        let presenter: PostDetailsPresenter = .init(
            view: viewController,
            parameters: parameters
        )

        viewController.presenter = presenter
        
        return viewController
    }
}
