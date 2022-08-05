//
//  CollectionFirstIndexAndElementTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CollectionFirstIndexAndElementTest: XCTestCase {
    // MARK: Test Data
    private let nums: [Int] = [1, 3, 5]
    
    // MARK: Tests
    func testInvalidElement() {
        XCTAssertNil(nums.firstIndexAndElement { $0 == 0 })
    }
    
    func testValidElement() {
        let result: (index: Int, element: Int)? = nums.firstIndexAndElement { $0 * $0 >= 10 }
        
        XCTAssertEqual(result?.index, 2)
        XCTAssertEqual(result?.element, 5)
    }
}
