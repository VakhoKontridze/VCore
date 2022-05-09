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
    private let input: String = "+0123456789"
    private let output: String = "0123456789"
    
    func testRemoving() {
        let result: String = input.removing(.symbols)
        
        XCTAssertEqual(result, output)
    }
    
    func testRemove() {
        var result: String = input; result.remove(.symbols)
        
        XCTAssertEqual(result, output)
    }
}
