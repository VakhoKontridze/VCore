//
//  ArrayCompactMapNonEmptyTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayCompactMapNonEmptyTests: XCTestCase {
    func testStringArray() {
        let input: [String] = ["", "Lorem Ipsum"]
        let output: [String] = ["Lorem Ipsum"]
        
        let result: [String] = input.compactMapNonEmpty { $0 }
        
        XCTAssertEqual(result, output)
    }
    
    func testOptionalStringArray() {
        let input: [String?] = [nil, "", "Lorem Ipsum"]
        let output: [String] = ["Lorem Ipsum"]
        
        let result: [String] = input.compactMapNonEmpty { $0 }
        
        XCTAssertEqual(result, output)
    }
}
