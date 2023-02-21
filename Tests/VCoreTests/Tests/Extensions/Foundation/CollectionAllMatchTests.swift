//
//  CollectionAllMatchTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.02.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CollectionAllMatchTests: XCTestCase {
    // MARK: Test Data
    private let array: [Int] = [1, 2, 3]
    private let set: Set<Int> = [1, 2, 3]
    private let dictionary: [Int: Int] = [1: 1, 2: 2, 3: 3]
    
    private let matchValue: Int = 2
    private let mismatchValue: Int = 1
    
    // MARK: Tests
    func testArray() {
        XCTAssertFalse(array.allMatch({ abs($0 - $1) <= mismatchValue }))
        XCTAssertTrue(array.allMatch({ abs($0 - $1) <= matchValue }))
    }
    
    func testSet() {
        XCTAssertFalse(set.allMatch({ abs($0 - $1) <= mismatchValue }))
        XCTAssertTrue(set.allMatch({ abs($0 - $1) <= matchValue }))
    }
    
    func testDictionary() {
        XCTAssertFalse(dictionary.allMatch({ abs($0.value - $1.value) <= mismatchValue }))
        XCTAssertTrue(dictionary.allMatch({ abs($0.value - $1.value) <= matchValue }))
    }
}
