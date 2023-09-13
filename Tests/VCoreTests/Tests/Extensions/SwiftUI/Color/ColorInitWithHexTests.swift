//
//  ColorInitWithHexTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import SwiftUI
import XCTest
@testable import VCore

// Other test cases are covered under `UIColorInitWithHexTests`

// MARK: - Tests
final class ColorInitWithHexTests: XCTestCase {
    func test() throws {
        let inputHex: String = "313AE0"
        let inputR: CGFloat = 49/255
        let inputG: CGFloat = 58/255
        let inputB: CGFloat = 224/255

        let output: Color = .init(red: inputR, green: inputG, blue: inputB, opacity: 1)

        let result: Color = try XCTUnwrap(Color(hex: inputHex))

        XCTAssertEqualColor(result, output)
    }
}
