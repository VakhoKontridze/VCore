//
//  StringProtocolReplacingTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.12.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class StringProtocolReplacingTests: XCTestCase {
    // MARK: Test Data
    private let input: String = "Lorem ipsum"
    private let output: String = "lorem ipsum"

    // MARK: Tests
    func testReplaced() {
        XCTAssertEqual(input.replaced(at: 0, with: "l"), output)
    }

    func testReplacing() {
        var result: String = input
        result.replacing(at: 0, with: "l")

        XCTAssertEqual(result, output)
    }
}
