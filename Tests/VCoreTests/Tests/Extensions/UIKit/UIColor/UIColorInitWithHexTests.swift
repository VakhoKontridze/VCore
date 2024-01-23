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
        let color: UIColor = try XCTUnwrap(
            UIColor(hex: "#10")
        )

        XCTAssertEqualColor(
            color,
            UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        )
    }

    func test4Digit_String() throws {
        let color: UIColor = try XCTUnwrap(
            UIColor(hex: "#1010")
        )

        XCTAssertEqualColor(
            color,
            UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 16/255)
        )
    }

    func test6Digit_String() throws {
        let color: UIColor = try XCTUnwrap(
            UIColor(hex: "#007AFF")
        )

        XCTAssertEqualColor(
            color,
            UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        )
    }

    func test8Digit_String() throws {
        let color: UIColor = try XCTUnwrap(
            UIColor(hex: "#007AFF10")
        )

        XCTAssertEqualColor(
            color,
            UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 16/255)
        )
    }

    func testManyDigit_String() {
        let color: UIColor? = .init(hex: "#000000007AFF")

        XCTAssertNil(color)
    }

    func testNoHashSymbol_String() throws {
        let color: UIColor = try XCTUnwrap(
            UIColor(hex: "007AFF")
        )

        XCTAssertEqualColor(
            color,
            UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        )
    }

    func test6Digit_UInt() throws {
        let color: UIColor = try XCTUnwrap(
            UIColor(hex: 0x007AFF)
        )

        XCTAssertEqualColor(
            color,
            UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        )
    }

    func testManyDigit_UInt() throws {
        let color: UIColor = try XCTUnwrap(
            UIColor(hex: 0x000000007AFF) // +0(6)
        )

        XCTAssertEqualColor(
            color,
            UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        )
    }
}

#endif
