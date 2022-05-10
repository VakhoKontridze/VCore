//
//  ArrayCompactMapNonEmptyTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayCompactMapNonEmptyTests: XCTestCase {
    func testStringArray() {
        XCTAssertEqual(
            ["", "Lorem Ipsum"].compactMapNonEmpty { $0 },
            ["Lorem Ipsum"]
        )
    }
    
    func testOptionalStringArray() {
        XCTAssertEqual(
            [nil, "", "Lorem Ipsum"].compactMapNonEmpty { $0 },
            ["Lorem Ipsum"]
        )
    }
}
