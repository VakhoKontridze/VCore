//
//  PostsMockGateway.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation

// MARK: - Posts Mock Gateway
struct PostsMockGateway: PostsGateway {
    func fetch() async throws -> PostsEntity {
        .mock
    }
}
