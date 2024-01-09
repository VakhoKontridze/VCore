//
//  UIColorInitWithHexTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

#if canImport(UIKit)

import XCTest
@testable import VCore

// MARK: - Tests
final class UIColorInitWithHexTests: XCTestCase {
    func test2Digit_String() throws {
        let inputHex: String = "#10"
        let inputR: CGFloat = 16/255
        let inputG: CGFloat = 16/255
        let inputB: CGFloat = 16/255

        let output: UIColor = .init(red: inputR, green: inputG, blue: inputB, alpha: 1)

        let result: UIColor = try XCTUnwrap(
            UIColor(hex: inputHex)
        )

        XCTAssertEqualColor(result, output)
    }

    func test4Digit_String() throws {
        let inputHex: String = "#1010"
        let inputR: CGFloat = 16/255
        let inputG: CGFloat = 16/255
        let inputB: CGFloat = 16/255
        let inputA: CGFloat = 16/255

        let output: UIColor = .init(red: inputR, green: inputG, blue: inputB, alpha: inputA)

        let result: UIColor = try XCTUnwrap(
            UIColor(hex: inputHex)
        )

        XCTAssertEqualColor(result, output)
    }

    func test6Digit_String() throws {
        let inputHex: String = "#007AFF"
        let inputR: CGFloat = 0/255
        let inputG: CGFloat = 122/255
        let inputB: CGFloat = 255/255

        let output: UIColor = .init(red: inputR, green: inputG, blue: inputB, alpha: 1)

        let result: UIColor = try XCTUnwrap(
            UIColor(hex: inputHex)
        )

        XCTAssertEqualColor(result, output)
    }

    func test8Digit_String() throws {
        let inputHex: String = "#007AFF10"
        let inputR: CGFloat = 0/255
        let inputG: CGFloat = 122/255
        let inputB: CGFloat = 255/255
        let inputA: CGFloat = 16/255

        let output: UIColor = .init(red: inputR, green: inputG, blue: inputB, alpha: inputA)

        let result: UIColor = try XCTUnwrap(
            UIColor(hex: inputHex)
        )

        XCTAssertEqualColor(result, output)
    }

    func testManyDigit_String() {
        XCTAssertNil(UIColor(hex: "#000000007AFF"))
    }

    func testNoHashSymbol_String() throws {
        let inputHex: String = "007AFF"
        let inputR: CGFloat = 0/255
        let inputG: CGFloat = 122/255
        let inputB: CGFloat = 255/255

        let output: UIColor = .init(red: inputR, green: inputG, blue: inputB, alpha: 1)

        let result: UIColor = try XCTUnwrap(
            UIColor(hex: inputHex)
        )

        XCTAssertEqualColor(result, output)
    }

    func test6Digit_UInt() throws {
        let inputHex: UInt = 0x007AFF
        let inputR: CGFloat = 0/255
        let inputG: CGFloat = 122/255
        let inputB: CGFloat = 255/255

        let output: UIColor = .init(red: inputR, green: inputG, blue: inputB, alpha: 1)

        let result: UIColor = try XCTUnwrap(
            UIColor(hex: inputHex)
        )

        XCTAssertEqualColor(result, output)
    }

    func testManyDigit_UInt() throws {
        let inputHex: UInt = 0x000000007AFF // +0(6)
        let inputR: CGFloat = 0/255
        let inputG: CGFloat = 122/255
        let inputB: CGFloat = 255/255

        let output: UIColor = .init(red: inputR, green: inputG, blue: inputB, alpha: 1)

        let result: UIColor = try XCTUnwrap(
            UIColor(hex: inputHex)
        )

        XCTAssertEqualColor(result, output)
    }
}

#endif
