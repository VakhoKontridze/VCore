//
//  PostsNetworkMockGateway.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

#if DEBUG

import Foundation

// MARK: - Posts Network Mock Gateway
struct PostsNetworkMockGateway: PostsGateway {
    func fetch() async throws -> PostsEntity {
        .mock
    }
}

#endif
