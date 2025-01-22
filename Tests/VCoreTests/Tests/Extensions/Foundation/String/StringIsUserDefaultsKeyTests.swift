//
//  StringIsUserDefaultsKeyTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct StringIsUserDefaultsKeyTests { // Can't be properly tested
    @Test
    func test() {
        let store: UserDefaults = .mock
        let key: String = "Key"
        
        store.set(1, forKey: key)

        #expect(key.isUserDefaultsKey(in: store))
    }
}
