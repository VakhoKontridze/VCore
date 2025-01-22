//
//  CollectionAllMatchTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 21.02.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CollectionAllMatchTests {
    @Test
    func testArray() {
        let array: [Int] = [1, 2, 3]

        #expect(!array.allMatch({ abs($0 - $1) <= 1 }))
        #expect(array.allMatch({ abs($0 - $1) <= 2 }))
    }
    
    @Test
    func testSet() {
        let set: Set<Int> = [1, 2, 3]

        #expect(!set.allMatch({ abs($0 - $1) <= 1 }))
        #expect(set.allMatch({ abs($0 - $1) <= 2 }))
    }
    
    @Test
    func testDictionary() {
        let dictionary: [Int: Int] = [1: 1, 2: 2, 3: 3]

        #expect(!dictionary.allMatch({ abs($0.value - $1.value) <= 1 }))
        #expect(dictionary.allMatch({ abs($0.value - $1.value) <= 2 }))
    }
}
