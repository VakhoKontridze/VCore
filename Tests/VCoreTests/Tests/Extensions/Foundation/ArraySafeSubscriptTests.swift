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
    private let nums: [Int] = [1, 3, 5]
    
    // MARK: Tests
    func testLowerOutOfBoundsSubscript() {
        XCTAssertNil(nums[safe: -1])
    }
    
    func testValidSubscript() {
        for i in nums.indices {
            XCTAssertEqual(nums[safe: i], nums[i])
        }
    }
    
    func testUpperOutOfBoundsSubscript() {
        XCTAssertNil(nums[safe: 3])
    }
}
