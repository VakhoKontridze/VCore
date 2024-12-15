//
//  ColorLightenAndDarkenTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import SwiftUI
import XCTest
@testable import VCore

// MARK: - Tests
final class ColorLightenAndDarkenTests: XCTestCase {
    func testLighten() {
        let color: Color = .init(red: 0.5, green: 0.5, blue: 0.5, opacity: 1)

        let values = color.lighten(by: 0.1).rgbaValues

        XCTAssertEqual(values.red, 0.6)
        XCTAssertEqual(values.green, 0.6)
        XCTAssertEqual(values.blue, 0.6)
        XCTAssertEqual(values.alpha, 1)
    }

    func testDarken() {
        let color: Color = .init(red: 0.5, green: 0.5, blue: 0.5, opacity: 1)

        let values = color.darken(by: 0.1).rgbaValues

        XCTAssertEqual(values.red, 0.4)
        XCTAssertEqual(values.green, 0.4)
        XCTAssertEqual(values.blue, 0.4)
        XCTAssertEqual(values.alpha, 1)
    }
}
