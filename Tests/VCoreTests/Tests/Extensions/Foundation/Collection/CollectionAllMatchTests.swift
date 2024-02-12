//
//  CollectionAllMatchTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.02.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class CollectionAllMatchTests: XCTestCase {
    func testArray() {
        let array: [Int] = [1, 2, 3]

        XCTAssertFalse(array.allMatch({ abs($0 - $1) <= 1 }))
        XCTAssertTrue(array.allMatch({ abs($0 - $1) <= 2 }))
    }
    
    func testSet() {
        let set: Set<Int> = [1, 2, 3]

        XCTAssertFalse(set.allMatch({ abs($0 - $1) <= 1 }))
        XCTAssertTrue(set.allMatch({ abs($0 - $1) <= 2 }))
    }
    
    func testDictionary() {
        let dictionary: [Int: Int] = [1: 1, 2: 2, 3: 3]

        XCTAssertFalse(dictionary.allMatch({ abs($0.value - $1.value) <= 1 }))
        XCTAssertTrue(dictionary.allMatch({ abs($0.value - $1.value) <= 2 }))
    }
}
