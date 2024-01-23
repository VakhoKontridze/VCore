//
//  IntRunBlockNTimesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class IntRunBlockNTimesTests: XCTestCase {
    func testBlock() {
        let number: Int = 5
        
        var sum: Int = 0
        number.times { sum += 1 }
        
        XCTAssertEqual(sum, 5)
    }
    
    func testBlockNumbered() {
        let number: Int = 5
        
        var sum: Int = 0
        number.times { sum += $0 }
        
        XCTAssertEqual(sum, 10)
    }
}
