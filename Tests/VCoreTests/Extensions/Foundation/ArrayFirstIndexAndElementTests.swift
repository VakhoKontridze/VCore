//
//  ArrayFirstIndexAndElementTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayFirstIndexAndElementTest: XCTestCase {
    private let input: [Int] = [1, 3, 5]
    
    func testInvalidElement() {
        XCTAssertNil(input.firstIndexAndElement { $0 == 0 })
    }
    
    func testValidElement() {
        let outputIndex: Int = 2
        let outputElement: Int = 5
        
        let result: (index: Int, element: Int)? = input.firstIndexAndElement { $0 * $0 >= 10 }
        
        XCTAssertEqual(result?.index, outputIndex)
        XCTAssertEqual(result?.element, outputElement)
    }
}
