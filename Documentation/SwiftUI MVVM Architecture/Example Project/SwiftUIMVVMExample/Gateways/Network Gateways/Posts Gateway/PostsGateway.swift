//  
//  PostsGateway.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation

// MARK: - Posts Gateway
protocol PostsGateway {
    func fetch() async throws -> PostsEntity
}
