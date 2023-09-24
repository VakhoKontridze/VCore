//
//  RangeReversedArrayOnConditionTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class RangeReversedArrayOnConditionTests: XCTestCase {
    // MARK: Test Data
    private let input: Range<Int> = 1..<4
    private let output: [Int] = [3, 2, 1]
    
    // MARK: Tests
    func testFalse() {
        let result: [Int] = input.reversedArray(false)
        
        XCTAssertNotEqual(result, output)
    }
    
    func testTrue() {
        let result: [Int] = input.reversedArray(true)
        
        XCTAssertEqual(result, output)
    }
}
