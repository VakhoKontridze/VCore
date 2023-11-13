//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Localization Manager
extension LocalizationManager {
    @available(*, unavailable, message: "Use `currentLocaleChangePublisher` instead")
    public static var currentLocaleDidChangeNotification: Notification.Name { fatalError() }
}

// MARK: - Network Reachability Service
extension NetworkReachabilityService {
    @available(*, unavailable, message: "Use `connectedPublisher` instead")
    public static var connectedNotification: Notification.Name { fatalError() }

    @available(*, unavailable, message: "Use `disconnectedPublisher` instead")
    public static var disconnectedNotification: Notification.Name { fatalError() }
}

// MARK: - Extensions - UIKit
#if canImport(UIKit) && !os(watchOS)

import UIKit

extension UIApplication {
    @available(*, deprecated, message: "Use method with `activationStates` parameter")
    public func firstWindow(
        where predicate: (UIWindow) throws -> Bool
    ) rethrows -> UIWindow? {
        try firstWindow(
            activationStates: [.foregroundActive],
            where: predicate
        )
    }
}

#endif
