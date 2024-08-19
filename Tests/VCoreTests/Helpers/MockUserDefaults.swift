//
//  MockUserDefaults.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation

// MARK: - User Defaults + Mock
extension UserDefaults {
    static let mock: UserDefaults = MockUserDefaults()
}

// MARK: - Mock User Defaults
final class MockUserDefaults: UserDefaults {
    // MARK: Properties
    private static var storage: [String: Any] = [:]

    // MARK: Methods
    override func object(forKey defaultName: String) -> Any? {
        Self.storage[defaultName]
    }

    override func set(_ value: Any?, forKey defaultName: String) {
        if let value {
            Self.storage[defaultName] = value
        } else {
            removeObject(forKey: defaultName)
        }
    }

    override func removeObject(forKey defaultName: String) {
        Self.storage.removeValue(forKey: defaultName)
    }
}
