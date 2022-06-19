//  
//  PostDetailsFactory.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - Post Details Factory
@MainActor struct PostDetailsFactory {
    // MARK: Initalizers
    private init() {}
    
    // MARK: Factory
    static func `default`(parameters: PostDetailsParameters) -> some View {
        PostDetailsView(
            presenter: PostDetailsPresenter(
                parameters: parameters
            )
        )
    }
    
    static func mock() -> some View {
        `default`(parameters: .mock)
    }
}
