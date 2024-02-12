//
//  StringRemovingCharacterSetTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class StringRemovingCharacterSetTests: XCTestCase {
    func testRemoving() {
        let string: String = "+0123456789"

        let trimmedString: String = string.removing(.symbols)

        XCTAssertEqual(trimmedString, "0123456789")
    }
    
    func testRemove() {
        let string: String = "+0123456789"

        var trimmedString: String = string
        trimmedString.remove(.symbols)

        XCTAssertEqual(trimmedString, "0123456789")
    }
}

final class StringRemovingCharacterSetsTests: XCTestCase {
    func testRemoving() {
        let string: String = "+0123456789A"

        let trimmedString: String = string.removing([.symbols, .letters])

        XCTAssertEqual(trimmedString, "0123456789")
    }
    
    func testRemove() {
        let string: String = "+0123456789A"

        var trimmedString: String = string
        trimmedString.remove([.symbols, .letters])

        XCTAssertEqual(trimmedString, "0123456789")
    }
}
