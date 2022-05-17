//
//  ArrayRemovingDuplicatesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayRemovingDuplicatesTests: XCTestCase {
    // MARK: Test Data
    private let input: [Int] = [1, 1, 3, 5, 5]
    private let output: [Int] = [1, 3, 5]
    
    // MARK: Tests
    func ArrayRemovingDuplicatesTests() {
        XCTAssertEqual(input.removingDuplicates(), output)
    }
    
    func testRemove() {
        var result: [Int] = input; result.removeDuplicates()
        
        XCTAssertEqual(result, output)
    }
}
