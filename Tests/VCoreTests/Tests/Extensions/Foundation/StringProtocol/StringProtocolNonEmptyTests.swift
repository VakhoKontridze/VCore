//
//  StringProtocolNonEmptyTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class StringProtocolNonEmptyTests: XCTestCase {
    func testIsEmptyOrWhiteSpace() {
        XCTAssertTrue("".isEmptyOrWhiteSpace)
        XCTAssertTrue(" ".isEmptyOrWhiteSpace)
        XCTAssertFalse("Lorem Ipsum".isEmptyOrWhiteSpace)
    }
    
    func testIsEmptyWhiteSpaceOrNewLines() {
        XCTAssertTrue("".isEmptyWhiteSpaceOrNewLines)
        XCTAssertTrue(" ".isEmptyWhiteSpaceOrNewLines)
        XCTAssertTrue("\n".isEmptyWhiteSpaceOrNewLines)
        XCTAssertFalse("Lorem Ipsum".isEmptyWhiteSpaceOrNewLines)
    }
    
    func testNonEmpty() {
        XCTAssertNil("".nonEmpty)
        XCTAssertEqual("Lorem Ipsum".nonEmpty, "Lorem Ipsum")
    }
    
    func testNonEmptyOrWhitespace() {
        XCTAssertNil("".nonEmptyOrWhiteSpace)
        XCTAssertNil(" ".nonEmptyOrWhiteSpace)
        XCTAssertEqual("Lorem Ipsum".nonEmptyOrWhiteSpace, "Lorem Ipsum")
    }
    
    func testNonEmptyWhitespaceOrNewLines() {
        XCTAssertNil("".nonEmptyWhiteSpaceOrNewLines)
        XCTAssertNil(" ".nonEmptyWhiteSpaceOrNewLines)
        XCTAssertNil("\n".nonEmptyWhiteSpaceOrNewLines)
        XCTAssertEqual("Lorem Ipsum".nonEmptyWhiteSpaceOrNewLines, "Lorem Ipsum")
    }
}
