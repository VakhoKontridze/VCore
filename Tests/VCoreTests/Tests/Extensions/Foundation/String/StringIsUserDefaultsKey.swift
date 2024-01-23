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
        UserDefaults.mock.set(5, forKey: key)

        XCTAssertTrue(key.isUserDefaultsKey(in: .mock))
    }
}
