//
//  PostsMockInteractor.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation

// MARK: - Posts Mock Interactor
struct PostsMockInteractor: PostsInteractive {
    func fetchPosts() async throws -> PostsEntity {
        try await PostsMockGateway().fetch()
    }
}
