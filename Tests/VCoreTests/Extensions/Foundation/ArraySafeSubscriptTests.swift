//
//  ArraySafeSubscriptTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ArraySafeSubscriptTests: XCTestCase {
    private let input: [Int] = [1, 3, 5]
    
    func testLowerOutOfBoundsSubscript() {
        XCTAssertNil(input[safe: -1])
    }
    
    func testValidSubscript() {
        for i in input.indices {
            let output: Int = input[i]
            
            let result: Int? = input[safe: i]
            
            XCTAssertEqual(result, output)
        }
    }
    
    func testUpperOutOfBoundsSubscript() {
        XCTAssertNil(input[safe: 3])
    }
}
