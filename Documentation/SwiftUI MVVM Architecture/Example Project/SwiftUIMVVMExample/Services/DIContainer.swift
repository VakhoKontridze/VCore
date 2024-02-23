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
    // MARK: Properties - Network Gateways
    private(set) lazy var networkGateways: NetworkGateways = .init()

    // MARK: Properties - Singleton
    static let current: DIContainer = .init()

    // MARK: Initializers
    private init() {}
}

// MARK: - Network Gateways
extension DIContainer {
    final class NetworkGateways {
        private(set) lazy var posts: any PostsGateway = make(
            PostsNetworkGateway(),
            preview: PostsMockGateway()
        )
    }
}

// MARK: - Factory
private func make<T>(
    _ value: @autoclosure () -> T,
    preview previewValue: @autoclosure () -> T
) -> T {
    if ProcessInfo.processInfo.isPreview {
        previewValue()
    } else {
        value()
    }
}
