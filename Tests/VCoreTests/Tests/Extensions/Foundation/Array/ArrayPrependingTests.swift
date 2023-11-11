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
        let input: [Int] = [2, 3]
        let result: [Int] = [1, 2, 3]

        let output: [Int] = input.prepending(1)

        XCTAssertEqual(result, output)
    }

    func testPrependElement() {
        let input: [Int] = [2, 3]
        let result: [Int] = [1, 2, 3]

        var output: [Int] = input
        output.prepend(1)

        XCTAssertEqual(result, output)
    }

    // MARK: Tests - Elements
    func testPrependingElements() {
        let input: [Int] = [3, 4]
        let result: [Int] = [1, 2, 3, 4]

        let output: [Int] = input.prepending(contentsOf: [1, 2])

        XCTAssertEqual(result, output)
    }

    func testPrependElements() {
        let input: [Int] = [3, 4]
        let result: [Int] = [1, 2, 3, 4]

        var output: [Int] = input
        output.prepend(contentsOf: [1, 2])

        XCTAssertEqual(result, output)
    }
}
