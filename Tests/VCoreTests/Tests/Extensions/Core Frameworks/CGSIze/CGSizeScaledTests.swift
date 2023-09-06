//
//  CGSizeScaledTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.09.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CGSizeScaledTests: XCTestCase {
    // MARK: Test data
    private let input: CGSize = .init(width: 3, height: 4)

    private let scaleConstant: CGFloat = 1
    private let scaleMultiplier: CGFloat = 2

    private let outputConstantUp: CGSize = .init(width: 4, height: 5)
    private let outputConstantDown: CGSize = .init(width: 2, height: 3)

    private let outputMultiplierUp: CGSize = .init(width: 6, height: 8)
    private let outputMultiplierDown: CGSize = .init(width: 1.5, height: 2)

    // MARK: Tests - Up with Constant
    func testScaledUpWithConstant() {
        let result: CGSize = input.scaledUp(withConstant: scaleConstant)

        XCTAssertEqual(result.width, outputConstantUp.width)
        XCTAssertEqual(result.height, outputConstantUp.height)
    }

    func testScaleUpWithConstant() {
        var result: CGSize = input
        result.scaleUp(withConstant: scaleConstant)

        XCTAssertEqual(result.width, outputConstantUp.width)
        XCTAssertEqual(result.height, outputConstantUp.height)
    }

    // MARK: Tests - Down with Constant
    func testScaledDownWithConstant() {
        let result: CGSize = input.scaledDown(withConstant: scaleConstant)

        XCTAssertEqual(result.width, outputConstantDown.width)
        XCTAssertEqual(result.height, outputConstantDown.height)
    }

    func testScaleDownWithConstant() {
        var result: CGSize = input
        result.scaleDown(withConstant: scaleConstant)

        XCTAssertEqual(result.width, outputConstantDown.width)
        XCTAssertEqual(result.height, outputConstantDown.height)
    }

    // MARK: Tests - Up with Multiplier
    func testScaledUpWithMultiplier() {
        let result: CGSize = input.scaledUp(withMultiplier: scaleMultiplier)

        XCTAssertEqual(result.width, outputMultiplierUp.width)
        XCTAssertEqual(result.height, outputMultiplierUp.height)
    }

    func testScaleUpWithMultiplier() {
        var result: CGSize = input
        result.scaleUp(withMultiplier: scaleMultiplier)

        XCTAssertEqual(result.width, outputMultiplierUp.width)
        XCTAssertEqual(result.height, outputMultiplierUp.height)
    }

    // MARK: Tests - Down with Multiplier
    func testScaledDownWithMultiplier() {
        let result: CGSize = input.scaledDown(withMultiplier: scaleMultiplier)

        XCTAssertEqual(result.width, outputMultiplierDown.width)
        XCTAssertEqual(result.height, outputMultiplierDown.height)
    }

    func testScaleDownWithMultiplier() {
        var result: CGSize = input
        result.scaleDown(withMultiplier: scaleMultiplier)

        XCTAssertEqual(result.width, outputMultiplierDown.width)
        XCTAssertEqual(result.height, outputMultiplierDown.height)
    }
}
