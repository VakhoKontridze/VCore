//
//  CollectionFirstAndLastIndexOfTypeTests.swift
//  Vore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CollectionFirstAndLastIndexOfTypeTests: XCTestCase {
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
        XCTAssertEqual(array.firstIndex(ofType: S1.self), 0)
    }

    func testFirstPredicate() {
        XCTAssertEqual(array.firstIndex(ofType: S1.self, where: { $0.value > 1 }), 1)
    }

    // MARK: Tests - Last
    func testLast() {
        XCTAssertEqual(array.lastIndex(ofType: S1.self), 5)
    }

    func testLastPredicate() {
        XCTAssertEqual(array.lastIndex(ofType: S1.self, where: { $0.value < 6 }), 4)
    }
}
