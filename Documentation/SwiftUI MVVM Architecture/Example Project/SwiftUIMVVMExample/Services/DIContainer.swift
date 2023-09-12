//
//  DIContainer.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 12.09.23.
//

import Foundation

// MARK: - DI Container
final class DIContainer {
    // MARK: Properties - Gateways
    var postsGateway: (any PostsGateway)!

    // MARK: Properties - Singleton
    static let current: DIContainer = .init()

    // MARK: Initializers
    private init() {}

    // MARK: Injection
    func injectDefault() {
        postsGateway = PostsNetworkGateway()
    }
}
