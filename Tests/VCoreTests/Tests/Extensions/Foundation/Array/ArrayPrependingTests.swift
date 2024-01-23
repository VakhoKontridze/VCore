//
//  ArrayPrependingTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayPrependingTests: XCTestCase {
    // MARK: Tests - Element
    func testPrependingElement() {
        let array: [Int] = [2, 3]

        let prependedArray: [Int] = array.prepending(1)

        XCTAssertEqual(prependedArray, [1, 2, 3])
    }

    func testPrependElement() {
        let array: [Int] = [2, 3]

        var prependedArray: [Int] = array
        prependedArray.prepend(1)

        XCTAssertEqual(prependedArray, [1, 2, 3])
    }

    // MARK: Tests - Elements
    func testPrependingElements() {
        let array: [Int] = [3, 4]

        let prependedArray: [Int] = array.prepending(contentsOf: [1, 2])

        XCTAssertEqual(prependedArray, [1, 2, 3, 4])
    }

    func testPrependElements() {
        let array: [Int] = [3, 4]

        var prependedArray: [Int] = array
        prependedArray.prepend(contentsOf: [1, 2])

        XCTAssertEqual(prependedArray, [1, 2, 3, 4])
    }
}
