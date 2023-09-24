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
    // MARK: Test Data
    private let input: ClosedRange<Int> = 1...3
    private let output: [Int] = [3, 2, 1]

    // MARK: Tests
    func testFalse() {
        let result: [Int] = input.reversedArray(false)

        XCTAssertNotEqual(result, output)
    }

    func testTrue() {
        let result: [Int] = input.reversedArray(true)

        XCTAssertEqual(result, output)
    }
}
