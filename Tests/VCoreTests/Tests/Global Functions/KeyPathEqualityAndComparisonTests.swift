//
//  KeyPathEqualityAndComparisonTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
final class KeyPathEqualityAndComparisonTests {
    // MARK: Test Data
    private struct Object {
        var a: Int = 0
        var b: Int = 0
        var c: Int = 0
    }
    
    // MARK: Tests
    @Test
    func testIsEqual() {
        #expect(
            isEqual(
                Object(),
                to: Object(),
                by: \.a, \.b, \.c
            )
        )

        #expect(
            !isEqual(
                Object(),
                to: Object(c: 1),
                by: \.a, \.b, \.c
            )
        )
    }
    
    @Test
    func testIsLess() {
        #expect(
            isLess(
                Object(),
                than: Object(c: 1),
                by: \.a, \.b, \.c
            )
        )
        
        #expect(
            !isLess(
                Object(),
                than: Object(),
                by: \.a, \.b, \.c
            )
        )
    }
    
    @Test
    func testIsLessThanOrEqual() {
        #expect(
            isLessThanOrEqual(
                Object(),
                to: .init(c: 1),
                by: \.a, \.b, \.c
            )
        )
        
        #expect(
            isLessThanOrEqual(
                Object(),
                to: Object(),
                by: \.a, \.b, \.c
            )
        )
        
        #expect(
            !isLessThanOrEqual(
                Object(),
                to: .init(c: -1),
                by: \.a, \.b, \.c
            )
        )
    }
    
    @Test
    func testIsGreater() {
        #expect(
            isGreater(
                Object(),
                than: Object(c: -1),
                by: \.a, \.b, \.c
            )
        )

        #expect(
            !isGreater(
                Object(),
                than: Object(),
                by: \.a, \.b, \.c
            )
        )
    }
    
    @Test
    func testIsGreaterThanOrEqual() {
        #expect(
            isGreaterThanOrEqual(
                Object(),
                to: Object(c: -1),
                by: \.a, \.b, \.c
            )
        )
        
        #expect(
            isGreaterThanOrEqual(
                Object(),
                to: Object(),
                by: \.a, \.b, \.c
            )
        )
        
        #expect(
            !isGreaterThanOrEqual(
                Object(),
                to: Object(c: 1),
                by: \.a, \.b, \.c
            )
        )
    }
}
