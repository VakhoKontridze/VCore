//
//  ColorInitWithHexTests.swift
//  VCore
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
        let inputHex: String = "#007AFF"
        let inputR: CGFloat = 0/255
        let inputG: CGFloat = 122/255
        let inputB: CGFloat = 255/255

        let output: Color = .init(red: inputR, green: inputG, blue: inputB, opacity: 1)

        let result: Color = try XCTUnwrap(Color(hex: inputHex))

        XCTAssertEqualColor(result, output)
    }
}
