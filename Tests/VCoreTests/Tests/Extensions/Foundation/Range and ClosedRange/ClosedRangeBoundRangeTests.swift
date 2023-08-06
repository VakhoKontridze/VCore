//
//  ClosedRangeBoundRangeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ClosedRangeBoundRangeTests: XCTestCase {
    func test() {
        XCTAssertEqual((3...10).boundRange, 7)
    }
}
