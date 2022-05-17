//
//  StringRemovingCharsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class StringRemovingCharsTests: XCTestCase {
    // MARK: Test Data
    private let input: String = "+0123456789"
    private let output: String = "0123456789"
    
    // MARK: Tests
    func testRemoving() {
        XCTAssertEqual(input.removing(.symbols), output)
    }
    
    func testRemove() {
        var result: String = input; result.remove(.symbols)
        
        XCTAssertEqual(result, output)
    }
}