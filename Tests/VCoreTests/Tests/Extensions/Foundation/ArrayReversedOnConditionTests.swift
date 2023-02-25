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
    
    // MARK: Tests
    func testFalse() {
        let result: [Int] = input.reversed(if: false)
        
        XCTAssertNotEqual(result, output)
    }
    
    func testTrue() {
        let result: [Int] = input.reversed(if: true)
        
        XCTAssertEqual(result, output)
    }
}
