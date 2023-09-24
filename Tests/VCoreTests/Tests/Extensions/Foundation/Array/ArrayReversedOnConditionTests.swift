//
//  ArrayReversedOnConditionTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayReversedOnConditionTests: XCTestCase {
    // MARK: Test Data
    private let input: [Int] = [1, 2, 3]
    private let output: [Int] = [3, 2, 1]
    
    // MARK: Tests - Reversed
    func testReversedFalse() {
        let result: [Int] = input.reversed(false)
        
        XCTAssertNotEqual(result, output)
    }
    
    func testReversedTrue() {
        let result: [Int] = input.reversed(true)
        
        XCTAssertEqual(result, output)
    }

    // MARK: Tests - Reverse
    func testReverseFalse() {
        var result = input; result.reverse(false)

        XCTAssertNotEqual(result, output)
    }

    func testReverseTrue() {
        var result = input; result.reverse(true)

        XCTAssertEqual(result, output)
    }
}
