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
    private(set) lazy var networkGateways: NetworkGateways = .init()

    // MARK: Properties - Singleton
    static let current: DIContainer = .init()

    // MARK: Initializers
    private init() {}
}

// MARK: - Network Gateways
extension DIContainer {
    final class NetworkGateways {
        fileprivate(set) lazy var posts: any FetchPostsGatewayProtocol = FetchPostsGateway()
    }
}

// MARK: - Environment Injections
#if DEBUG

extension DIContainer {
    func injectPreviewDependencies() {
        // Gateways - Network
        networkGateways.posts = MockFetchPostsGateway()
    }
}

#endif
