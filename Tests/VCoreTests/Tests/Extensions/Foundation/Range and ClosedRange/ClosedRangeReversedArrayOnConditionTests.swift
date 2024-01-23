//
//  ClosedRangeReversedArrayOnConditionTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.08.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ClosedRangeReversedArrayOnConditionTests: XCTestCase {
    func testFalse() {
        let range: ClosedRange<Int> = 1...3

        let reversedRange: [Int] = range.reversedArray(false)

        XCTAssertEqual(reversedRange, [1, 2, 3])
    }

    func testTrue() {
        let range: ClosedRange<Int> = 1...3

        let reversedRange: [Int] = range.reversedArray(true)

        XCTAssertEqual(reversedRange, [3, 2, 1])
    }
}
