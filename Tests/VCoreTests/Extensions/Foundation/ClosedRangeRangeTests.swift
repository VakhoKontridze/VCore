//
//  ClosedRangeRangeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ClosedRangeRangeTests: XCTestCase {
    func test() {
        let input: ClosedRange<Int> = 3...10
        let output: Int = 7
        
        let result: Int = input.range
        
        XCTAssertEqual(result, output)
    }
}
