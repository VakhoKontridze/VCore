//
//  OptionalComparisonTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 01.02.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct OptionalComparisonTests {
    // MARK: Test Data
    // Data is stored to avoid casting

    private let a: Int? = nil
    private let b: Int? = 10
    private let c: Int? = 20
    
    // MARK: Tests
    @Test
    func testIsLessClosure() {
        let a: String? = nil
        let b: String? = "Lorem ipsum"
        let c: String? = "z"

        let comparison: (String, String) -> Bool = { (a, b) in a.compare(b, options: .caseInsensitive) == .orderedAscending }

        #expect(a.isOptionalLess(than: b, order: .nilIsLess, comparison: comparison))
        #expect(a.isOptionalLess(than: c, order: .nilIsLess, comparison: comparison))
        #expect(b.isOptionalLess(than: c, order: .nilIsLess, comparison: comparison))

        #expect(!a.isOptionalLess(than: b, order: .nilIsGreater, comparison: comparison))
        #expect(!a.isOptionalLess(than: c, order: .nilIsGreater, comparison: comparison))
        #expect(b.isOptionalLess(than: c, order: .nilIsGreater, comparison: comparison))
    }

    @Test
    func testIsLess() {
        #expect(a.isOptionalLess(than: b, order: .nilIsLess))
        #expect(a.isOptionalLess(than: c, order: .nilIsLess))
        #expect(b.isOptionalLess(than: c, order: .nilIsLess))

        #expect(!a.isOptionalLess(than: b, order: .nilIsGreater))
        #expect(!a.isOptionalLess(than: c, order: .nilIsGreater))
        #expect(b.isOptionalLess(than: c, order: .nilIsGreater))
    }

    @Test
    func testIsGreater() {
        #expect(!a.isOptionalGreater(than: b, order: .nilIsLess))
        #expect(!a.isOptionalGreater(than: c, order: .nilIsLess))
        #expect(!b.isOptionalGreater(than: c, order: .nilIsLess))
        
        #expect(a.isOptionalGreater(than: b, order: .nilIsGreater))
        #expect(a.isOptionalGreater(than: c, order: .nilIsGreater))
        #expect(!b.isOptionalGreater(than: c, order: .nilIsGreater))
    }
    
    @Test
    func testIsLessThanOrEqual() {
        #expect(a.isOptionalLessThanOrEqual(to: b, order: .nilIsLess))
        #expect(a.isOptionalLessThanOrEqual(to: c, order: .nilIsLess))
        #expect(b.isOptionalLessThanOrEqual(to: c, order: .nilIsLess))
        
        #expect(!a.isOptionalLessThanOrEqual(to: b, order: .nilIsGreater))
        #expect(!a.isOptionalLessThanOrEqual(to: c, order: .nilIsGreater))
        #expect(b.isOptionalLessThanOrEqual(to: c, order: .nilIsGreater))
    }
    
    @Test
    func testIsGreaterThanOrEqual() {
        #expect(!a.isOptionalGreaterThanOrEqual(to: b, order: .nilIsLess))
        #expect(!a.isOptionalGreaterThanOrEqual(to: c, order: .nilIsLess))
        #expect(!b.isOptionalGreaterThanOrEqual(to: c, order: .nilIsLess))
        
        #expect(a.isOptionalGreaterThanOrEqual(to: b, order: .nilIsGreater))
        #expect(a.isOptionalGreaterThanOrEqual(to: c, order: .nilIsGreater))
        #expect(!b.isOptionalGreaterThanOrEqual(to: c, order: .nilIsGreater))
    }
}
