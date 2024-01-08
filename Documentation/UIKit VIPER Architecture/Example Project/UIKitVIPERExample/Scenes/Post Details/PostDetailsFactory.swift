//  
//  PostDetailsFactory.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit
import VCore

// MARK: - Post Details Factory
@NonInitializable
struct PostDetailsFactory {
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
