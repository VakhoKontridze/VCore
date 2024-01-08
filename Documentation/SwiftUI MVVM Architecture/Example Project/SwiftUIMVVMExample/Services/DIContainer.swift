//
//  DIContainer.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 12.09.23.
//

import Foundation
import VCore

// MARK: - DI Container
@NonInitializable
final class DIContainer {
    // MARK: Properties
    private(set) lazy var gateways: Gateways = .init()

    // MARK: Properties - Singleton
    static let current: DIContainer = .init()
}

// MARK: - Gateways
extension DIContainer {
    final class Gateways {
        // MARK: Properties
        lazy var posts: any PostsGateway = make(
            PostsNetworkGateway(),
            preview: PostsMockGateway()
        )

        // MARK: Helpers
        private func make<T>(
            _ object: @autoclosure () -> T,
            preview previewObject: @autoclosure () -> T
        ) -> T {
            if ProcessInfo.processInfo.isPreview {
                return previewObject()
            } else {
                return object()
            }
        }
    }
}
