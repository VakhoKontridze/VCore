//
//  StringProtocolContainsOnlyCharacterSetTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class StringContainsOnlyCharacterSetTests: XCTestCase {
    func test() {
        XCTAssertTrue("0123456789".contains(only: .decimalDigits))
        XCTAssertFalse("+0123456789".contains(only: .decimalDigits))
    }
}

final class StringContainsOnlyCharacterSetsTests: XCTestCase {
    func test() {
        XCTAssertTrue("0123456789A".contains(only: [.decimalDigits, .letters]))
        XCTAssertFalse("+0123456789A".contains(only: [.decimalDigits, .letters]))
    }
}
