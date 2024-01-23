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
        let range: ClosedRange<Int> = 3...10

        let boundRange: Int = range.boundRange

        XCTAssertEqual(boundRange, 7)
    }
}
