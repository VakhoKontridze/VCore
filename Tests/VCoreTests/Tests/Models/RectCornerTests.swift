//
//  RectCornerTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.04.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class RectCornerTests: XCTestCase {
    func testReversedLeftAndRightCorners() {
        XCTAssertEqual(RectCorner.topLeft.withReversedLeftAndRightCorners(false), .topLeft)
        
        XCTAssertEqual(RectCorner.topLeft.withReversedLeftAndRightCorners(), .topRight)
        XCTAssertEqual(RectCorner.topRight.withReversedLeftAndRightCorners(), .topLeft)
        XCTAssertEqual(RectCorner.bottomRight.withReversedLeftAndRightCorners(), .bottomLeft)
        XCTAssertEqual(RectCorner.bottomLeft.withReversedLeftAndRightCorners(), .bottomRight)
        
        XCTAssertEqual(RectCorner(), [])
        XCTAssertEqual(RectCorner.allCorners.withReversedLeftAndRightCorners(), .allCorners)
        
        XCTAssertEqual(RectCorner.topCorners.withReversedLeftAndRightCorners(), .topCorners)
        XCTAssertEqual(RectCorner.rightCorners.withReversedLeftAndRightCorners(), .leftCorners)
        XCTAssertEqual(RectCorner.bottomCorners.withReversedLeftAndRightCorners(), .bottomCorners)
        XCTAssertEqual(RectCorner.leftCorners.withReversedLeftAndRightCorners(), .rightCorners)
        
        XCTAssertEqual(RectCorner([.topLeft, .bottomRight]).withReversedLeftAndRightCorners(), [.topRight, .bottomLeft])
        XCTAssertEqual(RectCorner([.topRight, .bottomLeft]).withReversedLeftAndRightCorners(), [.topLeft, .bottomRight])
        XCTAssertEqual(RectCorner([.bottomLeft, .bottomRight]).withReversedLeftAndRightCorners(), [.bottomRight, .bottomLeft])
        XCTAssertEqual(RectCorner([.bottomRight, .bottomLeft]).withReversedLeftAndRightCorners(), [.bottomLeft, .bottomRight])
    }
}
