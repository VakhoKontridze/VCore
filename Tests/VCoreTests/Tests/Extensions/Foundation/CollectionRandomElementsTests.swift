//
//  CollectionRandomElementsTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 30.04.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CollectionRandomElementsTests: XCTestCase {
    // MARK: Test Data
    private let nums: [Int] = [1, 3, 5, 7, 9]

    // MARK: Tests
    func testValid() throws {
        try 10.times {
            let randomNums: [Int] = try XCTUnwrap(nums.randomElements(Int.random(in: 0...nums.count)))

            XCTAssertTrue(randomNums.isUnique == true)
            XCTAssertLessThanOrEqual(randomNums.count, nums.count)
        }
    }

    func testOutOfBounds() {
        XCTAssertNil(nums.randomElements(-1))
        XCTAssertNil(nums.randomElements(nums.count+1))
    }
}
