//
//  CollectionFirstAndLastIndexAndElementTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CollectionFirstAndLastIndexAndElementTest: XCTestCase {
    // MARK: Test Data
    private let numbers: [Int] = [1, 3, 5, 7]
    
    // MARK: Tests - First
    func testFirstInvalidElement() {
        XCTAssertNil(numbers.firstIndexAndElement(where: { $0 == 0 }))
    }
    
    func testFirstValidElement() {
        let result: (index: Int, element: Int)? = numbers.firstIndexAndElement(where: { $0 * $0 >= 10 })
        
        XCTAssertEqual(result?.index, 2)
        XCTAssertEqual(result?.element, 5)
    }

    // MARK: Tests - Last
    func testLastInvalidElement() {
        XCTAssertNil(numbers.lastIndexAndElement(where: { $0 == 0 }))
    }

    func testLastValidElement() {
        let result: (index: Int, element: Int)? = numbers.lastIndexAndElement(where: { $0 * $0 >= 10 })

        XCTAssertEqual(result?.index, 3)
        XCTAssertEqual(result?.element, 7)
    }
}
