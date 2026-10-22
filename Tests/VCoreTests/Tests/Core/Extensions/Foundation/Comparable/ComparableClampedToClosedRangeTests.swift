//
//  ComparableClampedToClosedRangeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 22/10/26.
//

import Foundation
import Testing
@testable import VCore

@Suite
nonisolated struct ComparableClampedToClosedRangeTests {
    // MARK: Tests - Closed Range
    @Test
    func testClampedToClosedRange() {
        #expect("a".clamped(to: "b"..."d") == "b")
        #expect("c".clamped(to: "b"..."d") == "c")
        #expect("e".clamped(to: "b"..."d") == "d")
    }

    @Test
    func testClampToClosedRange() {
        do {
            var value: String = "a"
            value.clamp(to: "b"..."d")

            #expect(value == "b")
        }

        do {
            var value: String = "c"
            value.clamp(to: "b"..."d")

            #expect(value == "c")
        }

        do {
            var value: String = "e"
            value.clamp(to: "b"..."d")

            #expect(value == "d")
        }
    }

    // MARK: Tests - Min and Max
    @Test
    func testClampedMinMax() {
        #expect("a".clamped(min: "b", max: "d") == "b")
        #expect("c".clamped(min: "b", max: "d") == "c")
        #expect("e".clamped(min: "b", max: "d") == "d")
    }

    @Test
    func testClampMinMax() {
        do {
            var value: String = "a"
            value.clamp(min: "b", max: "d")

            #expect(value == "b")
        }

        do {
            var value: String = "c"
            value.clamp(min: "b", max: "d")

            #expect(value == "c")
        }

        do {
            var value: String = "e"
            value.clamp(min: "b", max: "d")

            #expect(value == "d")
        }
    }

    // MARK: Tests - Generic
    @Test
    func testClampedInGenericContext() {
        func clamped<Value>(
            _ value: Value,
            to range: ClosedRange<Value>
        ) -> Value
            where Value: Comparable
        {
            value.clamped(to: range)
        }

        let int: Int = 0
        let double: Double = 5.5
        let string: String = "e"

        #expect(clamped(int, to: 1...10) == 1)
        #expect(clamped(double, to: 1...10) == 5.5)
        #expect(clamped(string, to: "b"..."d") == "d")
    }
}
