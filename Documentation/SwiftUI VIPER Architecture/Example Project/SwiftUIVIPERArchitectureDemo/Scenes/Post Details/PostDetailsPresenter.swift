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
    nonisolated private let parameters: PostDetailsParameters
    
    // MARK: Initializers
    nonisolated init(parameters: PostDetailsParameters) {
        self.parameters = parameters
        
        self._title = .init(initialValue: parameters.title)
        self._body = .init(initialValue: parameters.body)
    }

    // MARK: Presentable
    @Published var title: String
    @Published var body: String
}
