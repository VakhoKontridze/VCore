//
//  PresentationHostViewControllerStorage.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.03.23.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation

// MARK: - Presentation Host View Controller Storage
@available(tvOS, unavailable)
@available(visionOS, unavailable)
final class PresentationHostViewControllerStorage {
    // MARK: Properties
    static let shared: PresentationHostViewControllerStorage = .init()

    var storage: [String: PresentationHostViewController] = [:]
    
    // MARK: Initializers
    private init() {}
}

#endif
