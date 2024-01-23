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
    func testValid() throws {
        let numbers: [Int] = [1, 3, 5, 7, 9]

        try 10.times {
            let randomNumbers: [Int] = try XCTUnwrap(
                numbers.randomElements(Int.random(in: 0...numbers.count))
            )

            XCTAssertTrue(randomNumbers.isUnique == true)
            XCTAssertLessThanOrEqual(randomNumbers.count, numbers.count)
        }
    }

    func testOutOfBounds() {
        let numbers: [Int] = [1, 3, 5, 7, 9]

        XCTAssertNil(numbers.randomElements(-1))
        XCTAssertNil(numbers.randomElements(numbers.count+1))
    }
}
