//
//  ArrayReversedOnConditionTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayReversedOnConditionTests: XCTestCase {
    // MARK: Tests - Reversed
    func testReversedFalse() {
        let array: [Int] = [1, 2, 3]

        let reversedArray: [Int] = array.reversed(false)

        XCTAssertEqual(reversedArray, [1, 2, 3])
    }
    
    func testReversedTrue() {
        let array: [Int] = [1, 2, 3]

        let reversedArray: [Int] = array.reversed(true)

        XCTAssertEqual(reversedArray, [3, 2, 1])
    }

    // MARK: Tests - Reverse
    func testReverseFalse() {
        let array: [Int] = [1, 2, 3]

        var reversedArray: [Int] = array
        reversedArray.reverse(false)

        XCTAssertEqual(reversedArray, [1, 2, 3])
    }

    func testReverseTrue() {
        let array: [Int] = [1, 2, 3]

        var reversedArray: [Int] = array
        reversedArray.reverse(true)

        XCTAssertEqual(reversedArray, [3, 2, 1])
    }
}
