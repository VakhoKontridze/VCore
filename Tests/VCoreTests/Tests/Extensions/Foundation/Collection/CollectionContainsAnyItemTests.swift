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
        let inputA: [Int] = [1, 2, 3]
        let inputB: [Int] = [3, 4, 5]

        let result: Bool = inputA.containsAnyItem(fromCollection: inputB)

        XCTAssertTrue(result)
    }

    func testFalse() {
        let inputA: [Int] = [1, 2, 3]
        let inputB: [Int] = [4, 5, 6]

        let result: Bool = inputA.containsAnyItem(fromCollection: inputB)

        XCTAssertFalse(result)
    }

    func testEmptyCollection() {
        let inputA: [Int] = []
        let inputB: [Int] = [1]

        let result: Bool = inputA.containsAnyItem(fromCollection: inputB)

        XCTAssertFalse(result)
    }

    func testEmptyOtherCollection() {
        let inputA: [Int] = [1]
        let inputB: [Int] = []

        let result: Bool = inputA.containsAnyItem(fromCollection: inputB)

        XCTAssertTrue(result)
    }
}
