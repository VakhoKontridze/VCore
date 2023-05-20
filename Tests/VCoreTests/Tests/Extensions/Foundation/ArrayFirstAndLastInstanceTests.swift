//
//  ArrayFirstAndLastInstanceTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 29.11.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayFirstAndLastInstanceTests: XCTestCase {
    // MARK: Test Data
    private let array: [any P] = [
        S1(value: 1),
        S2(value: 2),
        S2(value: 3),
        S1(value: 4)
    ]
    
    // MARK: Tests
    func testFirst() {
        XCTAssertEqual(array.firstInstanceOfType(S1.self)?.value, 1)
    }
    
    func testLast() {
        XCTAssertEqual(array.lastInstanceOfType(S1.self)?.value, 4)
    }
}

// MARK: - Test Data
private protocol P {
    var value: Int { get }
}

private struct S1: P { let value: Int }

private struct S2: P { let value: Int }
