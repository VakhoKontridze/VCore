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
    private let input: String = "+0123456789"
    private let output: String = "0123456789"
    
    func testKeeping() {
        let result: String = input.keeping(only: .decimalDigits)
        
        XCTAssertEqual(result, output)
    }
    
    func testKeep() {
        var result: String = input; result.keep(only: .decimalDigits)
        
        XCTAssertEqual(result, output)
    }
}
