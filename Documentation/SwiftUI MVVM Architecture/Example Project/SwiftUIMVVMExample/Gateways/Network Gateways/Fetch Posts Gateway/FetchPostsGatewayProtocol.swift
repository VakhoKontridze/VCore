//
//  PostsGatewayProtocol.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation

// MARK: - Fetch Posts Gateway Protocol
protocol FetchPostsGatewayProtocol {
    func fetch() async throws -> FetchPostsEntity
}
