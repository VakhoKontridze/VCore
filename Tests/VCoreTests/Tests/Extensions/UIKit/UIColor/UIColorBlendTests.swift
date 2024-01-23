//
//  UIColorBlendTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

#if canImport(UIKit)

import XCTest
@testable import VCore

// MARK: - Tests
final class UIColorBlendTests: XCTestCase {
    func testBlend() {
        let color1: UIColor = .init(red: 1/3, green: 1/3, blue: 1/3, alpha: 1)
        let color2: UIColor = .init(red: 2/3, green: 2/3, blue: 2/3, alpha: 1)

        let values = UIColor.blend(color1, with: color2).rgbaValues

        XCTAssertEqual(values.red, 0.5)
        XCTAssertEqual(values.green, 0.5)
        XCTAssertEqual(values.blue, 0.5)
        XCTAssertEqual(values.alpha, 1)
    }

    func testBlendWeighted() {
        let color1: UIColor = .init(red: 1/3, green: 1/3, blue: 1/3, alpha: 1)
        let color2: UIColor = .init(red: 2/3, green: 2/3, blue: 2/3, alpha: 1)

        let values = UIColor.blend(color1, ratio1: 0.2, with: color2, ratio2: 0.8).rgbaValues

        XCTAssertEqual(values.red, 0.6)
        XCTAssertEqual(values.green, 0.6)
        XCTAssertEqual(values.blue, 0.6)
        XCTAssertEqual(values.alpha, 1)
    }

    func testLighten() {
        let color: UIColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)

        let values = color.lighten(by: 0.1).rgbaValues

        XCTAssertEqual(values.red, 0.6)
        XCTAssertEqual(values.green, 0.6)
        XCTAssertEqual(values.blue, 0.6)
        XCTAssertEqual(values.alpha, 1)
    }

    func testDarken() {
        let color: UIColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)

        let values = color.darken(by: 0.1).rgbaValues

        XCTAssertEqual(values.red, 0.4)
        XCTAssertEqual(values.green, 0.4)
        XCTAssertEqual(values.blue, 0.4)
        XCTAssertEqual(values.alpha, 1)
    }
}

#endif
