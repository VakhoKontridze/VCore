//
//  CollectionFirstAndLastIndexAndElementOfTypeTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.08.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CollectionFirstAndLastIndexAndElementOfTypeTests: XCTestCase {
    // MARK: Test Data
    private let array: [any P] = [
        S1(value: 1),
        S1(value: 2),
        S2(value: 3),
        S2(value: 4),
        S1(value: 5),
        S1(value: 6)
    ]

    // MARK: Tests - First
    func testFirst() {
        let result: (index: Int, element: S1)? = array.firstIndexAndElement(ofType: S1.self)

        XCTAssertEqual(result?.index, 0)
        XCTAssertEqual(result?.element.value, 1)
    }

    func testFirstPredicate() {
        let result: (index: Int, element: S1)? = array.firstIndexAndElement(ofType: S1.self, where: { $0.value > 1 })

        XCTAssertEqual(result?.index, 1)
        XCTAssertEqual(result?.element.value, 2)
    }

    // MARK: Tests - Last
    func testLast() {
        let result: (index: Int, element: S1)? = array.lastIndexAndElement(ofType: S1.self)

        XCTAssertEqual(result?.index, 5)
        XCTAssertEqual(result?.element.value, 6)
    }

    func testLastPredicate() {
        let result: (index: Int, element: S1)? = array.lastIndexAndElement(ofType: S1.self, where: { $0.value < 6 })

        XCTAssertEqual(result?.index, 4)
        XCTAssertEqual(result?.element.value, 5)
    }
}
