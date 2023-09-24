//
//  NumericWithOppositeSignTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class NumericWithOppositeSignTests: XCTestCase {
    // MARK: Test Data
    private let input: Int = 10
    
    private let output: Int = -10
    
    // MARK: Tests
    func testConditionalFalse() {
        let result: Int = input.withOppositeSign(false)
        
        XCTAssertNotEqual(result, output)
    }
    
    func testConditionalTrue() {
        let result: Int = input.withOppositeSign(true)
        
        XCTAssertEqual(result, output)
    }
}
