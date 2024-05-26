//
//  Logging.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12.02.24.
//

import Foundation
import OSLog

// MARK: - Loggers
extension Logger {
    static let baseButtonGestureRecognizer: Self = .init(subsystem: "VCore", category: "BaseButtonGestureRecognizer")
    static let carouselCollectionViewFlowLayout: Self = .init(subsystem: "VCore", category: "CarouselCollectionViewFlowLayout")
    static let infiniteScrollingUICollectionView: Self = .init(subsystem: "VCore", category: "InfiniteScrollingUICollectionView")
    
    static let keychainService: Self = .init(subsystem: "VCore", category: "KeychainService")
    static let localizationManager: Self = .init(subsystem: "VCore", category: "LocalizationManager")
    static let presentationHost: Self = .init(subsystem: "VCore", category: "PresentationHost")
    static let networkReachabilityService: Self = .init(subsystem: "VCore", category: "NetworkReachabilityService")

    static let misc: Self = .init(subsystem: "VCore", category: "Misc")
}
