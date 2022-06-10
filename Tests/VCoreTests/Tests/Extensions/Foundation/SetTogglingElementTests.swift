//
//  SetTogglingElementTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class SetTogglingElementTests: XCTestCase {
    // MARK: Test Data
    private let num: Int = 1
    private let input: Set<Int> = [1, 3, 5]
    private var output: Set<Int> { input }
    private var outputRemoved: Set<Int> { input.subtracting([num]) }
    
    // MARK: Tests
    func testToggling() {
        let set1: Set<Int> = input
        
        let set2: Set<Int> = set1.toggling(num)
        XCTAssertEqual(set2, outputRemoved)
        
        let set3: Set<Int> = set2.toggling(num)
        XCTAssertEqual(set3, output)
    }
    
    func testToggle() {
        var result: Set<Int> = input
        
        result.toggle(num)
        XCTAssertEqual(result, outputRemoved)
        
        result.toggle(num)
        XCTAssertEqual(result, output)
    }
}
