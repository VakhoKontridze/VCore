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
        let input: Int = 5
        let output: Int = input
        
        var result: Int = 0
        input.times { result += 1 }
        
        XCTAssertEqual(result, output)
    }
    
    func testBlockNumbered() {
        let input: Int = 5
        let output: Int = (0..<5).reduce(0, +)
        
        var result: Int = 0
        input.times { result += $0 }
        
        XCTAssertEqual(result, output)
    }
}
