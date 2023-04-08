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
    private struct SomeOptionSet: OptionSet {
        static let first: Self = .init(rawValue: 1 << 0)
        static let second: Self = .init(rawValue: 1 << 1)
        static let third: Self = .init(rawValue: 1 << 2)
        
        static var all: Self { [.first, .second, .third] }
        
        let rawValue: Int
    }
    
    // MARK: Tests
    func testSingle() {
        XCTAssertEqual(SomeOptionSet.first.elements, [SomeOptionSet.first])
        XCTAssertEqual(SomeOptionSet.second.elements, [SomeOptionSet.second])
        XCTAssertEqual(SomeOptionSet.third.elements, [SomeOptionSet.third])
    }
    
    func testSet() {
        XCTAssertEqual(
            SomeOptionSet.all.elements,
            [.first, .second, .third]
        )
    }
}
