//
//  MockFetchPostsGateway.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

#if DEBUG

import Foundation

// MARK: - Mock Fetch Posts Gateway
struct MockFetchPostsGateway: FetchPostsGatewayProtocol {
    func fetch() async throws -> FetchPostsEntity {
        .mock
    }
}

#endif
