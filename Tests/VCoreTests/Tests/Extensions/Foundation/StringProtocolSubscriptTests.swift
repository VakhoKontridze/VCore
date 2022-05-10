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
    private let input: String = "Lorem ipsum"
    private let output: String = "lorem ipsum"
    
    func testGet() {
        XCTAssertEqual("Lorem Ipsum"[0], "L")
    }
    
    func testSetReplaced() {
        XCTAssertEqual(input.replaced(at: 0, with: "l"), output)
    }
    
    func testSetReplaceing() {
        var result: String = input; result.replacing(at: 0, with: "l")
        
        XCTAssertEqual(result, output)
    }
}
