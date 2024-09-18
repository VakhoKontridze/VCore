//
//  KeyPathEqualityAndCompraisonTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class KeyPathEqualityAndCompraisonTests: XCTestCase {
    // MARK: Test Data
    private struct Object {
        var a: Int = 0
        var b: Int = 0
        var c: Int = 0
    }
    
    // MARK: Tests
    func testIsEqual() {
        XCTAssertTrue(
            VCore.isEqual(
                Object(),
                to: Object(),
                by: \.a, \.b, \.c
            )
        )

        XCTAssertFalse(
            VCore.isEqual(
                Object(),
                to: Object(c: 1),
                by: \.a, \.b, \.c
            )
        )
    }
    
    func testIsLess() {
        XCTAssertTrue(
            isLess(
                Object(),
                than: Object(a: 1, b: 1, c: 1),
                by: \.a, \.b, \.c
            )
        )
        
        XCTAssertFalse(
            isLess(
                Object(),
                than: Object(),
                by: \.a, \.b, \.c
            )
        )
    }
    
    func testIsLessThanOrEqual() {
        XCTAssertTrue(
            VCore.isLessThanOrEqual(
                Object(),
                to: .init(c: 1),
                by: \.a, \.b, \.c
            )
        )
        
        XCTAssertTrue(
            VCore.isLessThanOrEqual(
                Object(),
                to: Object(),
                by: \.a, \.b, \.c
            )
        )
        
        XCTAssertFalse(
            VCore.isLessThanOrEqual(
                Object(),
                to: .init(c: -1),
                by: \.a, \.b, \.c
            )
        )
    }
    
    func testIsGreater() {
        XCTAssertTrue(
            isGreater(
                Object(),
                than: Object(a: -1, b: -1, c: -1),
                by: \.a, \.b, \.c
            )
        )

        XCTAssertFalse(
            isGreater(
                Object(),
                than: Object(),
                by: \.a, \.b, \.c
            )
        )
    }
    
    func testIsGreaterThanOrEqual() {
        XCTAssertTrue(
            VCore.isGreaterThanOrEqual(
                Object(),
                to: Object(c: -1),
                by: \.a, \.b, \.c
            )
        )
        
        XCTAssertTrue(
            VCore.isGreaterThanOrEqual(
                Object(),
                to: Object(),
                by: \.a, \.b, \.c
            )
        )
        
        XCTAssertFalse(
            VCore.isGreaterThanOrEqual(
                Object(),
                to: Object(c: 1),
                by: \.a, \.b, \.c
            )
        )
    }
}
