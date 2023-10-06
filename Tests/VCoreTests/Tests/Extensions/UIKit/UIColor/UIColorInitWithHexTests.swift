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
    func test2Char() throws {
        let inputHex: UInt64 = 0x10
        let inputR: CGFloat = 16/255
        let inputG: CGFloat = 16/255
        let inputB: CGFloat = 16/255

        let output: UIColor = .init(red: inputR, green: inputG, blue: inputB, alpha: 1)

        let result: UIColor = try XCTUnwrap(UIColor(hex: inputHex))

        XCTAssertEqualColor(result, output)
    }

    func test4Char() throws {
        let inputHex: UInt64 = 0x1010
        let inputR: CGFloat = 16/255
        let inputG: CGFloat = 16/255
        let inputB: CGFloat = 16/255
        let inputA: CGFloat = 16/255

        let output: UIColor = .init(red: inputR, green: inputG, blue: inputB, alpha: inputA)

        let result: UIColor = try XCTUnwrap(UIColor(hex: inputHex))

        XCTAssertEqualColor(result, output)
    }

    func test6Char() throws {
        let inputHex: UInt64 = 0x313AE0
        let inputR: CGFloat = 49/255
        let inputG: CGFloat = 58/255
        let inputB: CGFloat = 224/255

        let output: UIColor = .init(red: inputR, green: inputG, blue: inputB, alpha: 1)

        let result: UIColor = try XCTUnwrap(UIColor(hex: inputHex))

        XCTAssertEqualColor(result, output)
    }

    func test8Char() throws {
        let inputHex: UInt64 = 0x313AE010
        let inputR: CGFloat = 49/255
        let inputG: CGFloat = 58/255
        let inputB: CGFloat = 224/255
        let inputA: CGFloat = 16/255

        let output: UIColor = .init(red: inputR, green: inputG, blue: inputB, alpha: inputA)

        let result: UIColor = try XCTUnwrap(UIColor(hex: inputHex))

        XCTAssertEqualColor(result, output)
    }

    func testString() throws {
        let inputHex: String = "313AE0"
        let inputR: CGFloat = 49/255
        let inputG: CGFloat = 58/255
        let inputB: CGFloat = 224/255

        let output: UIColor = .init(red: inputR, green: inputG, blue: inputB, alpha: 1)

        let result: UIColor = try XCTUnwrap(UIColor(hex: inputHex))

        XCTAssertEqualColor(result, output)
    }

    func testHashSymbol() throws {
        let inputHex: String = "#313AE0"
        let inputR: CGFloat = 49/255
        let inputG: CGFloat = 58/255
        let inputB: CGFloat = 224/255

        let output: UIColor = .init(red: inputR, green: inputG, blue: inputB, alpha: 1)

        let result: UIColor = try XCTUnwrap(UIColor(hex: inputHex))

        XCTAssertEqualColor(result, output)
    }

    func testInvalidLength() {
        XCTAssertNil(UIColor(hex: 0x123456789))
    }
}

#endif
