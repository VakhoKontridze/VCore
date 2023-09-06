//
//  CGPointMovedTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.09.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CGPointMovedTests: XCTestCase {
    // MARK: Test data
    private let input: CGPoint = .init(x: 3, y: 4)

    private let moveValue: CGFloat = 1

    private let outputLeft: CGPoint = .init(x: 2, y: 4)
    private let outputRight: CGPoint = .init(x: 4, y: 4)
    private let outputUp: CGPoint = .init(x: 3, y: 3)
    private let outputDown: CGPoint = .init(x: 3, y: 5)

    // MARK: Tests - Left
    func testMovedLeftWithConstant() {
        let result: CGPoint = input.movedLeft(withValue: moveValue)

        XCTAssertEqual(result.x, outputLeft.x)
        XCTAssertEqual(result.y, outputLeft.y)
    }

    func testMoveLeftWithConstant() {
        var result: CGPoint = input
        result.moveLeft(withValue: moveValue)

        XCTAssertEqual(result.x, outputLeft.x)
        XCTAssertEqual(result.y, outputLeft.y)
    }

    // MARK: Tests - Right
    func testMovedRightWithConstant() {
        let result: CGPoint = input.movedRight(withValue: moveValue)

        XCTAssertEqual(result.x, outputRight.x)
        XCTAssertEqual(result.y, outputRight.y)
    }

    func testMoveRightWithConstant() {
        var result: CGPoint = input
        result.moveRight(withValue: moveValue)

        XCTAssertEqual(result.x, outputRight.x)
        XCTAssertEqual(result.y, outputRight.y)
    }

    // MARK: Tests - Up
    func testMovedUpWithConstant() {
        let result: CGPoint = input.movedUp(withValue: moveValue)

        XCTAssertEqual(result.x, outputUp.x)
        XCTAssertEqual(result.y, outputUp.y)
    }

    func testMoveUpWithConstant() {
        var result: CGPoint = input
        result.moveUp(withValue: moveValue)

        XCTAssertEqual(result.x, outputUp.x)
        XCTAssertEqual(result.y, outputUp.y)
    }

    // MARK: Tests - Down
    func testMovedDownWithConstant() {
        let result: CGPoint = input.movedDown(withValue: moveValue)

        XCTAssertEqual(result.x, outputDown.x)
        XCTAssertEqual(result.y, outputDown.y)
    }

    func testMoveDownWithConstant() {
        var result: CGPoint = input
        result.moveDown(withValue: moveValue)

        XCTAssertEqual(result.x, outputDown.x)
        XCTAssertEqual(result.y, outputDown.y)
    }
}
