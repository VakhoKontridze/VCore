//
//  DIContainer.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 12.09.23.
//

import Foundation
import VCore

// MARK: - DI Container
final class DIContainer {
    // MARK: Properties - Gateways
    lazy var networkGateways: NetworkGateways = .init()

    // MARK: Properties - Singleton
    static let shared: DIContainer = .init()

    // MARK: Initializers
    private init() {}
}

// MARK: - Network Gateways
extension DIContainer {
    final class NetworkGateways {
        lazy var posts: any FetchPostsGatewayProtocol = FetchPostsGateway()
    }
}

// MARK: - Preview Injection
#if DEBUG

extension DIContainer {
    func injectPreviewDependencies() {
        // Gateways - Network
        networkGateways.posts = MockFetchPostsGateway()
    }
}

#endif
