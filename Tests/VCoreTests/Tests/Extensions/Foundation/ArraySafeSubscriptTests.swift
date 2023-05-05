//
//  ArraySafeSubscriptTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ArraySafeSubscriptTests: XCTestCase {
    // MARK: Test Data
    private let numbers: [Int] = [1, 3, 5]
    
    // MARK: Tests
    func testLowerOutOfBoundsSubscript() {
        XCTAssertNil(numbers[safe: -1])
    }
    
    func testValidSubscript() {
        for i in numbers.indices {
            XCTAssertEqual(numbers[safe: i], numbers[i])
        }
    }
    
    func testUpperOutOfBoundsSubscript() {
        XCTAssertNil(numbers[safe: 3])
    }
}
