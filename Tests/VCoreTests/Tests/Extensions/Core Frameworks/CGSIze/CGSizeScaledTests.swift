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
    func testScaledUpWithConstant() {
        let input: CGSize = .init(width: 3, height: 4)
        let value: CGFloat = 1

        let result: CGSize = input.scaledUp(withConstant: value)

        XCTAssertEqual(result.width, input.width + value)
        XCTAssertEqual(result.height, input.height + value)
    }

    func testScaledDownWithConstant() {
        let input: CGSize = .init(width: 3, height: 4)
        let value: CGFloat = 1

        let result: CGSize = input.scaledDown(withConstant: value)

        XCTAssertEqual(result.width, input.width - value)
        XCTAssertEqual(result.height, input.height - value)
    }

    func testScaledUpWithMultiplier() {
        let input: CGSize = .init(width: 3, height: 4)
        let value: CGFloat = 1

        let result: CGSize = input.scaledUp(withMultiplier: value)

        XCTAssertEqual(result.width, input.width * value)
        XCTAssertEqual(result.height, input.height * value)
    }

    func testScaledDownWithMultiplier() {
        let input: CGSize = .init(width: 3, height: 4)
        let value: CGFloat = 1

        let result: CGSize = input.scaledDown(withMultiplier: value)

        XCTAssertEqual(result.width, input.width / value)
        XCTAssertEqual(result.height, input.height / value)
    }
}
