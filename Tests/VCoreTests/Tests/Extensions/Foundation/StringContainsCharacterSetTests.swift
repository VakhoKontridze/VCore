//
//  StringContainsCharacterSetTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class StringContainsCharacterSetTests: XCTestCase {
    func test() {
        XCTAssertTrue("0123456789".contains(.decimalDigits))
        XCTAssertFalse("0123456789".contains(.symbols))
    }
}

// MARK: - Tests
final class StringContainsCharacterSetsTests: XCTestCase {
    func test() {
        XCTAssertTrue("+0123456789".contains([.decimalDigits, .letters]))
        XCTAssertTrue("0123456789A".contains([.decimalDigits, .letters]))
        XCTAssertTrue("+0123456789A".contains([.decimalDigits, .letters]))
        XCTAssertFalse("0123456789".contains([.symbols, .letters]))
    }
}
