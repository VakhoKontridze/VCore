//
//  LogicalExclusiveOrTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class LogicalExclusiveOrTests: XCTestCase {
    func test() {
        XCTAssertEqual(false ^^ false, false)
        XCTAssertEqual(false ^^ true, true)
        XCTAssertEqual(true ^^ false, true)
        XCTAssertEqual(true ^^ true, false)
    }
}
