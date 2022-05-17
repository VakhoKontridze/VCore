//
//  StringKeepingOnlyCharsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class StringKeepingOnlyCharsTests: XCTestCase {
    // MARK: Test Data
    private let input: String = "+0123456789"
    private let output: String = "0123456789"
    
    // MARK: Tests
    func testKeeping() {
        XCTAssertEqual(input.keeping(only: .decimalDigits), output)
    }
    
    func testKeep() {
        var result: String = input; result.keep(only: .decimalDigits)
        
        XCTAssertEqual(result, output)
    }
}
