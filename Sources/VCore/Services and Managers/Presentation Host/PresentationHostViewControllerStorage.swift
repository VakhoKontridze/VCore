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
@MainActor final class PresentationHostViewControllerStorage {
    // MARK: Properties
    var storage: [String: _PresentationHostViewController] = [:]
    
    static let shared: PresentationHostViewControllerStorage = .init()
    
    // MARK: Initializers
    private init() {}
}

#endif
