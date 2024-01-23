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
    private struct Gender: OptionSet {
        static let male: Self = .init(rawValue: 1 << 0)
        static let female: Self = .init(rawValue: 1 << 1)

        static var all: Self { [.male, .female] }

        let rawValue: Int
    }

    // MARK: Tests
    func testSingle() {
        XCTAssertEqual(Gender.male.elements, [Gender.male])
        XCTAssertEqual(Gender.female.elements, [Gender.female])
    }
    
    func testMultiple() {
        XCTAssertEqual(
            Gender.all.elements,
            [.male, .female]
        )
    }
}
