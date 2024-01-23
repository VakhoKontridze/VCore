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
    // MARK: Tests - First
    func testFirstInvalidElement() {
        let numbers: [Int] = [1, 3, 5, 7]

        XCTAssertNil(numbers.firstIndexAndElement(where: { $0 == 0 }))
    }
    
    func testFirstValidElement() {
        let numbers: [Int] = [1, 3, 5, 7]

        let data: (index: Int, element: Int)? = numbers.firstIndexAndElement(where: { $0 * $0 >= 10 })
        
        XCTAssertEqual(data?.index, 2)
        XCTAssertEqual(data?.element, 5)
    }

    // MARK: Tests - Last
    func testLastInvalidElement() {
        let numbers: [Int] = [1, 3, 5, 7]

        XCTAssertNil(numbers.lastIndexAndElement(where: { $0 == 0 }))
    }

    func testLastValidElement() {
        let numbers: [Int] = [1, 3, 5, 7]

        let data: (index: Int, element: Int)? = numbers.lastIndexAndElement(where: { $0 * $0 >= 10 })

        XCTAssertEqual(data?.index, 3)
        XCTAssertEqual(data?.element, 7)
    }
}
