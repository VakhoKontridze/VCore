//  
//  PostsInteractor.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation

// MARK: - Posts Interactor
struct PostsInteractor: PostsInteractive {
    func fetchPosts() async throws -> PostsEntity {
        try await PostsNetworkGateway().fetch()
    }
}
