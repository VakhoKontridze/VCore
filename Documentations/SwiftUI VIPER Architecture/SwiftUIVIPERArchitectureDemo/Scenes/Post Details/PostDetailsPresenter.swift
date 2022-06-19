//  
//  PostDetailsPresenter.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation
import VCore

// MARK: - Post Details Presenter
@MainActor final class PostDetailsPresenter: PostDetailsPresentable {
    // MARK: Properties
    private let parameters: PostDetailsParameters
    
    // MARK: Initialzers
    init(parameters: PostDetailsParameters) {
        self.parameters = parameters
        
        self.title = parameters.title
        self.body = parameters.body
    }

    // MARK: Presentable
    @Published var title: String
    @Published var body: String
}
