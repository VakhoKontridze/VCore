//
//  CGSizeScaledTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.09.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class CGSizeScaledTests: XCTestCase {
    // MARK: Tests - Up with Constant
    func testScaledUpWithConstant() {
        let size: CGSize = .init(width: 3, height: 4)

        let scaledSize: CGSize = size.scaledUp(withConstant: 1)

        XCTAssertEqual(scaledSize.width, 4)
        XCTAssertEqual(scaledSize.height, 5)
    }

    func testScaleUpWithConstant() {
        let size: CGSize = .init(width: 3, height: 4)

        var scaledSize: CGSize = size
        scaledSize.scaleUp(withConstant: 1)

        XCTAssertEqual(scaledSize.width, 4)
        XCTAssertEqual(scaledSize.height, 5)
    }

    // MARK: Tests - Down with Constant
    func testScaledDownWithConstant() {
        let size: CGSize = .init(width: 3, height: 4)

        let scaledSize: CGSize = size.scaledDown(withConstant: 1)

        XCTAssertEqual(scaledSize.width, 2)
        XCTAssertEqual(scaledSize.height, 3)
    }

    func testScaleDownWithConstant() {
        let size: CGSize = .init(width: 3, height: 4)

        var scaledSize: CGSize = size
        scaledSize.scaleDown(withConstant: 1)

        XCTAssertEqual(scaledSize.width, 2)
        XCTAssertEqual(scaledSize.height, 3)
    }

    // MARK: Tests - Up with Multiplier
    func testScaledUpWithMultiplier() {
        let size: CGSize = .init(width: 3, height: 4)

        let scaledSize: CGSize = size.scaledUp(withMultiplier: 2)

        XCTAssertEqual(scaledSize.width, 6)
        XCTAssertEqual(scaledSize.height, 8)
    }

    func testScaleUpWithMultiplier() {
        let size: CGSize = .init(width: 3, height: 4)

        var scaledSize: CGSize = size
        scaledSize.scaleUp(withMultiplier: 2)

        XCTAssertEqual(scaledSize.width, 6)
        XCTAssertEqual(scaledSize.height, 8)
    }

    // MARK: Tests - Down with Multiplier
    func testScaledDownWithMultiplier() {
        let size: CGSize = .init(width: 3, height: 4)

        let scaledSize: CGSize = size.scaledDown(withMultiplier: 2)

        XCTAssertEqual(scaledSize.width, 1.5)
        XCTAssertEqual(scaledSize.height, 2)
    }

    func testScaleDownWithMultiplier() {
        let size: CGSize = .init(width: 3, height: 4)
        
        var scaledSize: CGSize = size
        scaledSize.scaleDown(withMultiplier: 2)

        XCTAssertEqual(scaledSize.width, 1.5)
        XCTAssertEqual(scaledSize.height, 2)
    }
}
