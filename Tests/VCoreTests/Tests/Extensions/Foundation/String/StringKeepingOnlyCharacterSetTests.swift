//
//  StringKeepingOnlyCharacterSetTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class StringKeepingCharacterSetTests: XCTestCase {
    func testKeeping() {
        let string: String = "+0123456789"

        let trimmedString: String = string.keeping(only: .decimalDigits)

        XCTAssertEqual(trimmedString, "0123456789")
    }
    
    func testKeep() {
        let string: String = "+0123456789"

        var trimmedString: String = string
        trimmedString.keep(only: .decimalDigits)

        XCTAssertEqual(trimmedString, "0123456789")
    }
}

// MARK: - Tests
final class StringKeepingCharacterSetsTests: XCTestCase {
    func testKeeping() {
        let string: String = "+0123456789A"

        let trimmedString: String = string.keeping(only: [.decimalDigits, .symbols])

        XCTAssertEqual(trimmedString, "+0123456789")
    }
    
    func testKeep() {
        let string: String = "+0123456789A"

        var trimmedString: String = string
        trimmedString.keep(only: [.decimalDigits, .symbols])

        XCTAssertEqual(trimmedString, "+0123456789")
    }
}
