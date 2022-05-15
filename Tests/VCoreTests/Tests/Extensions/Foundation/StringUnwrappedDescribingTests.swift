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
        let num: Int? = 5
        
        XCTAssertEqual(
            .init(unwrappedDescribing: num)!, // fatalError
            "5"
        )
    }
    
    func testnil() {
        let num: Int? = nil
        
        XCTAssertNil(String(unwrappedDescribing: num))
    }
}
