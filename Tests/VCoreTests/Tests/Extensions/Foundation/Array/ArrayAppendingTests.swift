//
//  ArrayAppendingTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.11.23.
//

import Foundation

import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayAppendingTests: XCTestCase {
    // MARK: Tests - Element
    func testPrependingElement() {
        let input: [Int] = [1, 2]
        let result: [Int] = [1, 2, 3]

        let output: [Int] = input.appending(3)

        XCTAssertEqual(result, output)
    }

    // MARK: Tests - Elements
    func testPrependingElements() {
        let input: [Int] = [1, 2]
        let result: [Int] = [1, 2, 3, 4]

        let output: [Int] = input.appending(contentsOf: [3, 4])

        XCTAssertEqual(result, output)
    }
}
