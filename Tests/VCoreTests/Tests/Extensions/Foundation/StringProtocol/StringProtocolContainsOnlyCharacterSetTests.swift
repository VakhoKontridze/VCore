//
//  StringProtocolContainsOnlyCharacterSetTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import XCTest
@testable import VCore

// MARK: - String Protocol Contains Only Character Set Tests
final class StringContainsOnlyCharacterSetTests: XCTestCase {
    func test() {
        XCTAssertTrue("0123456789".contains(only: .decimalDigits))
        XCTAssertFalse("+0123456789".contains(only: .decimalDigits))
    }
}

// MARK: - String Protocol Contains Only Character Sets Tests
final class StringContainsOnlyCharacterSetsTests: XCTestCase {
    func test() {
        XCTAssertTrue("0123456789A".contains(only: [.decimalDigits, .letters]))
        XCTAssertFalse("+0123456789A".contains(only: [.decimalDigits, .letters]))
    }
}
