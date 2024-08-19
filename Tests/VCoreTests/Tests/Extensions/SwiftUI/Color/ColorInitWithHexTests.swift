//
//  ColorInitWithHexTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

// Other test cases are covered under `UIColorInitWithHexTests`

import SwiftUI
import XCTest
@testable import VCore

// MARK: - Tests
final class ColorInitWithHexTests: XCTestCase {
    func test() throws {
        let color: Color = try XCTUnwrap(
            Color(hex: "#007AFF")
        )

        XCTAssertEqualColor(
            color,
            Color(red: 0/255, green: 122/255, blue: 255/255)
        )
    }
}
