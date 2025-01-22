//
//  CollectionFirstAndLastIndexOfTypeTests.swift
//  Vore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CollectionFirstAndLastIndexOfTypeTests {
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

    // MARK: Tests
    @Test
    func testFirstIndex() {
        #expect(array.firstIndex(ofType: S1.self) == 0)
        #expect(array.firstIndex(ofType: S1.self, where: { $0.value > 1 }) == 1)
    }

    @Test
    func testLastIndex() {
        #expect(array.lastIndex(ofType: S1.self) == 5)
        #expect(array.lastIndex(ofType: S1.self, where: { $0.value < 6 }) == 4)
    }
}
