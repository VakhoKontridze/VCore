//
//  PresentationHostViewControllerStorage.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.03.23.
//

#if os(iOS)

import Foundation

// MARK: - Presentation Host View Controller Storage
final class PresentationHostViewControllerStorage {
    // MARK: Properties
    var storage: [String: PresentationHostViewController] = [:]
    
    static let shared: PresentationHostViewControllerStorage = .init()
    
    // MARK: Initializers
    private init() {}
}

#endif
