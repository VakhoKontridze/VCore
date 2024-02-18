//
//  UIColorInitWithHexTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

#if canImport(UIKit)

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class UIColorInitWithHexTests: XCTestCase {
    func test6Digit_String() throws {
        let color: UIColor = try XCTUnwrap(
            UIColor(hex: "#007AFF")
        )

        XCTAssertEqualColor(
            color,
            UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        )
    }

    func testManyCharacters_String() {
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

    func testManyCharacters_UInt() throws {
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
