//
//  StringUnwrappedDescribingTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class StringUnwrappedDescribingTests: XCTestCase {
    func testValue() {
        let input: Int? = 5
        let output: String = "5"
        
        let result: String = .init(unwrappedDescribing: input)!
        
        XCTAssertEqual(result, output)
    }
    
    func testnil() {
        let input: Int? = nil
        
        let result: String? = .init(unwrappedDescribing: input)
        
        XCTAssertNil(result)
    }
}
