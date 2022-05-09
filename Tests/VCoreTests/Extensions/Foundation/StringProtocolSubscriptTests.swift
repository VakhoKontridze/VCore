//
//  StringProtocolSubscriptTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class StringProtocolSubscriptTests: XCTestCase {
    func testGet() {
        let input: String = "Lorem Ipsum"
        let output: Character = "L"
        
        let result: Character = input[0]
        
        XCTAssertEqual(result, output)
    }
    
    func testSetReplaced() {
        let input: String = "Lorem ipsum"
        let output: String = "lorem ipsum"
        
        let result: String = input.replaced(at: 0, with: "l")
        
        XCTAssertEqual(result, output)
    }
    
    func testSetReplaceing() {
        let input: String = "Lorem ipsum"
        let output: String = "lorem ipsum"
        
        var result: String = input; result.replacing(at: 0, with: "l")
        
        XCTAssertEqual(result, output)
    }
}
