//
//  CollectionFirstAndLastIndexAndElementOfTypeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.08.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CollectionFirstAndLastIndexAndElementOfTypeTests {
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
    func testFirstElementAndIndex() {
        do {
            let result: (index: Int, element: S1)? = array.firstIndexAndElement(ofType: S1.self)

            #expect(result?.index == 0)
            #expect(result?.element.value == 1)
        }
        
        do {
            let result: (index: Int, element: S1)? = array.firstIndexAndElement(ofType: S1.self, where: { $0.value > 1 })

            #expect(result?.index == 1)
            #expect(result?.element.value == 2)
        }
    }

    @Test
    func testLastElementAndIndex() {
        do {
            let result: (index: Int, element: S1)? = array.lastIndexAndElement(ofType: S1.self)

            #expect(result?.index == 5)
            #expect(result?.element.value == 6)
        }
        
        do {
            let result: (index: Int, element: S1)? = array.lastIndexAndElement(ofType: S1.self, where: { $0.value < 6 })

            #expect(result?.index == 4)
            #expect(result?.element.value == 5)
        }
    }
}
