//
//  StringProtocolSubscriptTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct StringProtocolSubscriptTests {
    @Test
    func testGet() {
        #expect("Lorem Ipsum"[0] == "L")
    }
    
    @Test
    func testSet() {
        var string: String = "Lorem ipsum"
        string[0] = "l"

        #expect(string == "lorem ipsum")
    }
}
