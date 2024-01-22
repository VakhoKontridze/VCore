//
//  OptionSetElementsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 20.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class OptionSetElementsTests: XCTestCase {
    // MARK: Test Data
    struct RGBColor: OptionSet {
        static let red: Self = .init(rawValue: 1 << 0)
        static let green: Self = .init(rawValue: 1 << 1)
        static let blue: Self = .init(rawValue: 1 << 2)

        static var all: Self { [.red, .green, .blue] }

        let rawValue: Int
    }

    // MARK: Tests
    func testSingle() {
        XCTAssertEqual(RGBColor.red.elements, [RGBColor.red])
        XCTAssertEqual(RGBColor.green.elements, [RGBColor.green])
        XCTAssertEqual(RGBColor.blue.elements, [RGBColor.blue])
    }
    
    func testMultiple() {
        XCTAssertEqual(
            RGBColor.all.elements,
            [.red, .green, .blue]
        )
    }
}
