//
//  CollectionContainsAnyItemTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CollectionContainsAnyItemTests: XCTestCase {
    func testTrue() {
        let array1: [Int] = [1, 2, 3]
        let array2: [Int] = [3, 4, 5]

        let contains: Bool = array1.containsAnyItem(fromCollection: array2)

        XCTAssertTrue(contains)
    }

    func testFalse() {
        let array1: [Int] = [1, 2, 3]
        let array2: [Int] = [4, 5, 6]

        let contains: Bool = array1.containsAnyItem(fromCollection: array2)

        XCTAssertFalse(contains)
    }

    func testEmptyCollection() {
        let array1: [Int] = []
        let array2: [Int] = [1]

        let contains: Bool = array1.containsAnyItem(fromCollection: array2)

        XCTAssertFalse(contains)
    }

    func testEmptyOtherCollection() {
        let array1: [Int] = [1]
        let array2: [Int] = []

        let contains: Bool = array1.containsAnyItem(fromCollection: array2)

        XCTAssertTrue(contains)
    }
}
