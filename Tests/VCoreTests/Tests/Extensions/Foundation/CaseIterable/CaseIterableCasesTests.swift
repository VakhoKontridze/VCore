//
//  CaseIterableCasesTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.05.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class CaseIterableCasesTests: XCTestCase {
    // MARK: Test Data
    private enum CardinalDirection: CaseIterable {
        case north
        case east
        case south
        case west
    }

    // MARK: Tests
    func testOffset() {
        let current: CardinalDirection = .east

        XCTAssertEqual(current.aCase(offsetBy: -2), nil)
        XCTAssertEqual(current.aCase(offsetBy: -1), .north)
        XCTAssertEqual(current.aCase(offsetBy: 0), .east)
        XCTAssertEqual(current.aCase(offsetBy: 1), .south)
        XCTAssertEqual(current.aCase(offsetBy: 2), .west)
        XCTAssertEqual(current.aCase(offsetBy: 3), nil)
    }

    func testPrevious() {
        XCTAssertEqual(CardinalDirection.east.previousCase, .north)
        XCTAssertEqual(CardinalDirection.north.previousCase, nil)
    }

    func testNext() {
        XCTAssertEqual(CardinalDirection.south.nextCase, .west)
        XCTAssertEqual(CardinalDirection.west.nextCase, nil)
    }
}
