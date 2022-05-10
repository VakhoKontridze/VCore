//
//  ClosedRangeRangeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ClosedRangeRangeTests: XCTestCase {
    func test() {
        XCTAssertEqual((3...10).range, 7)
    }
}
