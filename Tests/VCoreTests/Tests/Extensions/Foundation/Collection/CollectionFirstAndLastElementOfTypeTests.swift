//
//  CollectionFirstAndLastElementOfTypeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 29.11.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class CollectionFirstAndLastElementOfTypeTests: XCTestCase {
    // MARK: Test Data
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
        XCTAssertEqual(array.firstElement(ofType: S1.self)?.value, 1)
    }

    func testFirstPredicate() {
        XCTAssertEqual(array.firstElement(ofType: S1.self, where: { $0.value > 1 })?.value, 2)
    }

    // MARK: Tests - Last
    func testLast() {
        XCTAssertEqual(array.lastElement(ofType: S1.self)?.value, 6)
    }

    func testLastPredicate() {
        XCTAssertEqual(array.lastElement(ofType: S1.self, where: { $0.value < 6 })?.value, 5)
    }
}

private protocol P { // MARK: TODO: Swift 5.10 - Move into test
    var value: Int { get }
}
