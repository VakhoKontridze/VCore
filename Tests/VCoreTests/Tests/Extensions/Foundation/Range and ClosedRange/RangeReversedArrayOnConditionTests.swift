//
//  RangeReversedArrayOnConditionTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class RangeReversedArrayOnConditionTests: XCTestCase {
    func testFalse() {
        let range: Range<Int> = 1..<4

        let reversedArray: [Int] = range.reversedArray(false)
        
        XCTAssertEqual(reversedArray, [1, 2 ,3])
    }
    
    func testTrue() {
        let range: Range<Int> = 1..<4

        let reversedArray: [Int] = range.reversedArray(true)

        XCTAssertEqual(reversedArray, [3, 2, 1])
    }
}
