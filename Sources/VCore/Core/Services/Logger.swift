//
//  Logger.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12.02.24.
//

import Foundation
import OSLog

nonisolated extension Logger {
    // MARK: Properties - Core - Utilities
    static let keyboardObserver: Self = .init("KeyboardObserver")
    static let keychainStorage: Self = .init("KeychainStorage")
    static let publishedKeychainStorage: Self = .init("PublishedKeychainStorage")
    
    // MARK: Properties - Core - Services
    static let keychainService: Self = .init("KeychainService")
    static let localizationManager: Self = .init("LocalizationManager")
    static let networkReachabilityService: Self = .init("NetworkReachabilityService")
    static let userDefaultsService: Self = .init("UserDefaultsService")
    
    // MARK: Properties - Presentation - Views
    static let alignedGridLayout: Self = .init("AlignedGridLayout")
    static let baseButtonGestureRecognizer: Self = .init("BaseButtonGestureRecognizer")
    static let carouselCollectionViewFlowLayout: Self = .init("CarouselCollectionViewFlowLayout")
    static let infiniteScrollingUICollectionView: Self = .init("InfiniteScrollingUICollectionView")
    static let keyboardResponsiveUIViewController: Self = .init("KeyboardResponsiveUIViewController")
    static let modalPresenter: Self = .init("ModalPresenter")

    // MARK: Properties - Misc
    static let misc: Self = .init("Misc")
}

nonisolated extension Logger {
    fileprivate init(_ category: String) {
        self.init(subsystem: "VCore", category: category)
    }
}
