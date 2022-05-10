//
//  MockUserDefaults.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation

// MARK: - Mock User Defaults
extension UserDefaults {
    static let mock: UserDefaults = MockUserDefaults()
}

final class MockUserDefaults: UserDefaults {
    private static var storage: [String: Any] = [:]
    
    override class func setValue(_ value: Any?, forKey key: String) {
        storage[key] = value
    }
    
    override class func value(forKey key: String) -> Any? {
        storage[key]
    }
    
    override func removeObject(forKey defaultName: String) {
        Self.storage.removeValue(forKey: defaultName)
    }
}
