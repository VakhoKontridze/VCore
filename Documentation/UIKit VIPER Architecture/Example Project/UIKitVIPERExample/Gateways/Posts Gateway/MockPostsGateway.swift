//
//  MockFetchPostsGateway.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 21.01.24.
//

import Foundation

// MARK: - Mock Fetch Posts Gateway
struct MockFetchPostsGateway: FetchPostsGatewayProtocol {
    func fetch(completion: @escaping (Result<FetchPostsEntity, any Error>) -> Void) {
        completion(.success(.mock))
    }
}

