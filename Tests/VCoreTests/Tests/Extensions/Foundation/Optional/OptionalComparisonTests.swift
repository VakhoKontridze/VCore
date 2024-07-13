//
//  OptionalComparisonTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 01.02.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class OptionalComparisonTests: XCTestCase {
    // MARK: Test Data
    // Data is stored to avoid casting

    private let a: Int? = nil
    private let b: Int? = 10
    private let c: Int? = 20
    
    // MARK: Tests
    func testIsLessClosure() {
        let a: String? = nil
        let b: String? = "Lorem ipsum"
        let c: String? = "z"

        let comparison: (String, String) -> Bool = { (a, b) in a.compare(b, options: .caseInsensitive) == .orderedAscending }

        XCTAssertTrue(a.isOptionalLess(than: b, order: .nilIsLess, comparison: comparison))
        XCTAssertTrue(a.isOptionalLess(than: c, order: .nilIsLess, comparison: comparison))
        XCTAssertTrue(b.isOptionalLess(than: c, order: .nilIsLess, comparison: comparison))

        XCTAssertFalse(a.isOptionalLess(than: b, order: .nilIsGreater, comparison: comparison))
        XCTAssertFalse(a.isOptionalLess(than: c, order: .nilIsGreater, comparison: comparison))
        XCTAssertTrue(b.isOptionalLess(than: c, order: .nilIsGreater, comparison: comparison))
    }

    func testIsLess() {
        XCTAssertTrue(a.isOptionalLess(than: b, order: .nilIsLess))
        XCTAssertTrue(a.isOptionalLess(than: c, order: .nilIsLess))
        XCTAssertTrue(b.isOptionalLess(than: c, order: .nilIsLess))

        XCTAssertFalse(a.isOptionalLess(than: b, order: .nilIsGreater))
        XCTAssertFalse(a.isOptionalLess(than: c, order: .nilIsGreater))
        XCTAssertTrue(b.isOptionalLess(than: c, order: .nilIsGreater))
    }

    func testIsGreater() {
        XCTAssertFalse(a.isOptionalGreater(than: b, order: .nilIsLess))
        XCTAssertFalse(a.isOptionalGreater(than: c, order: .nilIsLess))
        XCTAssertFalse(b.isOptionalGreater(than: c, order: .nilIsLess))
        
        XCTAssertTrue(a.isOptionalGreater(than: b, order: .nilIsGreater))
        XCTAssertTrue(a.isOptionalGreater(than: c, order: .nilIsGreater))
        XCTAssertFalse(b.isOptionalGreater(than: c, order: .nilIsGreater))
    }
    
    func testIsLessThanOrEqual() {
        XCTAssertTrue(a.isOptionalLessThanOrEqual(to: b, order: .nilIsLess))
        XCTAssertTrue(a.isOptionalLessThanOrEqual(to: c, order: .nilIsLess))
        XCTAssertTrue(b.isOptionalLessThanOrEqual(to: c, order: .nilIsLess))
        
        XCTAssertFalse(a.isOptionalLessThanOrEqual(to: b, order: .nilIsGreater))
        XCTAssertFalse(a.isOptionalLessThanOrEqual(to: c, order: .nilIsGreater))
        XCTAssertTrue(b.isOptionalLessThanOrEqual(to: c, order: .nilIsGreater))
    }
    
    func testIsGreaterThanOrEqual() {
        XCTAssertFalse(a.isOptionalGreaterThanOrEqual(to: b, order: .nilIsLess))
        XCTAssertFalse(a.isOptionalGreaterThanOrEqual(to: c, order: .nilIsLess))
        XCTAssertFalse(b.isOptionalGreaterThanOrEqual(to: c, order: .nilIsLess))
        
        XCTAssertTrue(a.isOptionalGreaterThanOrEqual(to: b, order: .nilIsGreater))
        XCTAssertTrue(a.isOptionalGreaterThanOrEqual(to: c, order: .nilIsGreater))
        XCTAssertFalse(b.isOptionalGreaterThanOrEqual(to: c, order: .nilIsGreater))
    }
}
