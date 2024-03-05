//
//  CollectionFirstAndLastIndexAndElementOfTypeTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.08.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class CollectionFirstAndLastIndexAndElementOfTypeTests: XCTestCase {
    // MARK: Test Data
    private protocol P {
        var value: Int { get }
    }

    private struct S1: P { let value: Int }
    private struct S2: P { let value: Int }

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
        let data: (index: Int, element: S1)? = array.firstIndexAndElement(ofType: S1.self)

        XCTAssertEqual(data?.index, 0)
        XCTAssertEqual(data?.element.value, 1)
    }

    func testFirstPredicate() {
        let data: (index: Int, element: S1)? = array.firstIndexAndElement(ofType: S1.self, where: { $0.value > 1 })

        XCTAssertEqual(data?.index, 1)
        XCTAssertEqual(data?.element.value, 2)
    }

    // MARK: Tests - Last
    func testLast() {
        let data: (index: Int, element: S1)? = array.lastIndexAndElement(ofType: S1.self)

        XCTAssertEqual(data?.index, 5)
        XCTAssertEqual(data?.element.value, 6)
    }

    func testLastPredicate() {
        let data: (index: Int, element: S1)? = array.lastIndexAndElement(ofType: S1.self, where: { $0.value < 6 })

        XCTAssertEqual(data?.index, 4)
        XCTAssertEqual(data?.element.value, 5)
    }
}
