//
//  CGPointMovedTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.09.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class CGPointMovedTests: XCTestCase {
    // MARK: Tests - Left
    func testMovedLeftWithConstant() {
        let point: CGPoint = .init(x: 3, y: 4)

        let movedPoint: CGPoint = point.movedLeft(withValue: 1)

        XCTAssertEqual(movedPoint.x, 2)
        XCTAssertEqual(movedPoint.y, 4)
    }

    func testMoveLeftWithConstant() {
        let point: CGPoint = .init(x: 3, y: 4)

        var movedPoint: CGPoint = point
        movedPoint.moveLeft(withValue: 1)

        XCTAssertEqual(movedPoint.x, 2)
        XCTAssertEqual(movedPoint.y, 4)
    }

    // MARK: Tests - Right
    func testMovedRightWithConstant() {
        let point: CGPoint = .init(x: 3, y: 4)

        let movedPoint: CGPoint = point.movedRight(withValue: 1)

        XCTAssertEqual(movedPoint.x, 4)
        XCTAssertEqual(movedPoint.y, 4)
    }

    func testMoveRightWithConstant() {
        let point: CGPoint = .init(x: 3, y: 4)

        var movedPoint: CGPoint = point
        movedPoint.moveRight(withValue: 1)

        XCTAssertEqual(movedPoint.x, 4)
        XCTAssertEqual(movedPoint.y, 4)
    }

    // MARK: Tests - Up
    func testMovedUpWithConstant() {
        let point: CGPoint = .init(x: 3, y: 4)

        let movedPoint: CGPoint = point.movedUp(withValue: 1)

        XCTAssertEqual(movedPoint.x, 3)
        XCTAssertEqual(movedPoint.y, 3)
    }

    func testMoveUpWithConstant() {
        let point: CGPoint = .init(x: 3, y: 4)

        var movedPoint: CGPoint = point
        movedPoint.moveUp(withValue: 1)

        XCTAssertEqual(movedPoint.x, 3)
        XCTAssertEqual(movedPoint.y, 3)
    }

    // MARK: Tests - Down
    func testMovedDownWithConstant() {
        let point: CGPoint = .init(x: 3, y: 4)

        let movedPoint: CGPoint = point.movedDown(withValue: 1)

        XCTAssertEqual(movedPoint.x, 3)
        XCTAssertEqual(movedPoint.y, 5)
    }

    func testMoveDownWithConstant() {
        let point: CGPoint = .init(x: 3, y: 4)

        var movedPoint: CGPoint = point
        movedPoint.moveDown(withValue: 1)

        XCTAssertEqual(movedPoint.x, 3)
        XCTAssertEqual(movedPoint.y, 5)
    }
}
