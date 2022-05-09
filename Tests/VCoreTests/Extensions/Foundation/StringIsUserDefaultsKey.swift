//
//  StringIsUserDefaultsKey.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class StringIsUserDefaultsKey: XCTestCase { // Can't be properly tested
    func test() {
        let key: String = "Key"
        let value: Int = 5
        UserDefaults.test.set(value, forKey: key)
        
        XCTAssertTrue(key.isUserDefaultsKey(in: .test))
    }
}

extension UserDefaults {
    fileprivate static let test: UserDefaults = TestUserDefaults()
}

private final class TestUserDefaults: UserDefaults {
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
