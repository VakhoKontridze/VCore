//
//  StringProtocolReplacedTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 11.12.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class StringProtocolReplacedTests: XCTestCase {
    func testReplaced() {
        let string: String = "Lorem ipsum"

        let replacedString: String = string.replaced(at: 0, with: "l")

        XCTAssertEqual(replacedString, "lorem ipsum")
    }

    func testReplacing() {
        let string: String = "Lorem ipsum"

        var replacedString: String = string
        replacedString.replace(at: 0, with: "l")

        XCTAssertEqual(replacedString, "lorem ipsum")
    }
}
