//
//  StringProtocolSubscriptTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class StringProtocolSubscriptTests: XCTestCase {
    // MARK: Test Data
    private let input: String = "Lorem ipsum"
    private let output: String = "lorem ipsum"
    
    // MARK: Tests
    func testGet() {
        XCTAssertEqual("Lorem Ipsum"[0], "L")
    }
    
    func testSet() {
        var result: String = input
        result[0] = "l"

        XCTAssertEqual(result, output)
    }
}
