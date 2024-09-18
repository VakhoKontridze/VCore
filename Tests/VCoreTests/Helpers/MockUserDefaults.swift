//
//  MockUserDefaults.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation

// MARK: - User Defaults + Mock
extension UserDefaults {
    nonisolated(unsafe) static let mock: UserDefaults = MockUserDefaults()
}

// MARK: - Mock User Defaults
final class MockUserDefaults: UserDefaults, @unchecked Sendable {
    // MARK: Properties
    nonisolated(unsafe) private static var storage: [String: Any] = [:]
    
    private let lock: NSLock = .init()

    // MARK: Methods
    override func object(forKey defaultName: String) -> Any? {
        lock.withLock({
            Self.storage[defaultName]
        })
    }

    override func set(_ value: Any?, forKey defaultName: String) {
        lock.withLock({
            if let value {
                Self.storage[defaultName] = value
            } else {
                removeObject(forKey: defaultName)
            }
        })
    }

    override func removeObject(forKey defaultName: String) {
        _ = lock.withLock({
            Self.storage.removeValue(forKey: defaultName)
        })
    }
}
