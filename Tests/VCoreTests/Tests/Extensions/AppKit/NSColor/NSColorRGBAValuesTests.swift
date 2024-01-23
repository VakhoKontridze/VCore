//
//  NSColorRGBAValuesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import XCTest
import AppKit
@testable import VCore

// MARK: - Tests
final class NSColorRGBAValuesTests: XCTestCase {
    func testValues() {
        let color: NSColor = .init(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.4)

        let values = color.rgbaValues

        XCTAssertEqual(values.red, 0.1)
        XCTAssertEqual(values.green, 0.2)
        XCTAssertEqual(values.blue, 0.3)
        XCTAssertEqual(values.alpha, 0.4)
    }
    
    func testComponents() {
        let color: NSColor = .init(red: 10.0/255, green: 20.0/255, blue: 30.0/255, alpha: 0.5)

        let components = color.rgbaComponents

        XCTAssertEqual(components.red, 10)
        XCTAssertEqual(components.green, 20)
        XCTAssertEqual(components.blue, 30)
        XCTAssertEqual(components.alpha, 0.5)
    }
    
    func testISRGBAEqual() {
        XCTAssertTrue(NSColor.red.isRGBAEqual(to: .red))
        XCTAssertFalse(NSColor.red.isRGBAEqual(to: .blue))
    }
}

#endif
