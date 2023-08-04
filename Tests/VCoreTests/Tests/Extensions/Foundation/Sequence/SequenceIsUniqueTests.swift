//
//  SequenceIsUniqueTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class SequenceIsUniqueTests: XCTestCase {
    // MARK: Test Data
    private let uniqueArray: [Int] = [1, 3, 5]
    private let nonUniqueArray: [Int] = [1, 1, 3, 5, 5]
    
    // MARK: Tests
    func testIsUnique() {
        XCTAssertTrue(uniqueArray.isUnique)
        XCTAssertFalse(nonUniqueArray.isUnique)
    }
    
    func testContainsDuplicates() {
        XCTAssertFalse(uniqueArray.containsDuplicates)
        XCTAssertTrue(nonUniqueArray.containsDuplicates)
    }
}
