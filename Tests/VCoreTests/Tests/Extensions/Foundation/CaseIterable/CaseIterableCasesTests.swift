//
//  CaseIterableCasesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 24.05.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CaseIterableCasesTests {
    // MARK: Test Data
    private enum CardinalDirection: CaseIterable {
        case north
        case east
        case south
        case west
    }

    // MARK: Tests
    @Test
    func testOffset() {
        #expect(CardinalDirection.east.aCase(offsetBy: -2) == nil)
        #expect(CardinalDirection.east.aCase(offsetBy: -1) == .north)
        #expect(CardinalDirection.east.aCase(offsetBy: 0) == .east)
        #expect(CardinalDirection.east.aCase(offsetBy: 1) == .south)
        #expect(CardinalDirection.east.aCase(offsetBy: 2) == .west)
        #expect(CardinalDirection.east.aCase(offsetBy: 3) == nil)
    }

    @Test
    func testPrevious() {
        #expect(CardinalDirection.east.previousCase == .north)
        #expect(CardinalDirection.north.previousCase == nil)
    }

    @Test
    func testNext() {
        #expect(CardinalDirection.south.nextCase == .west)
        #expect(CardinalDirection.west.nextCase == nil)
    }
}
