//
//  PresentationHostInteractiveViewFrameStorage.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.01.24.
//

import SwiftUI

// MARK: - Presentation Host Interactive View Frame Storage
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
final class PresentationHostInteractiveViewFrameStorage {
    // MARK: Properties
    static let shared: PresentationHostInteractiveViewFrameStorage = .init()

    private var storage: [String: CGRect] = [:]

    // MARK: Initializers
    private init() {}

    // MARK: Get and Set
    func get(key: String) -> CGRect? {
        storage[key]
    }

    func set(key: String, value: CGRect) {
        storage[key] = value
    }

    func remove(key: String) {
        storage.removeValue(forKey: key)
    }
}
