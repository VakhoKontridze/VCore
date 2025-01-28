//
//  ArrayReversedOnConditionTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ArrayReversedOnConditionTests {
    @Test
    func testReversedFalse() {
        #expect(
            [1, 2, 3].reversed(false) ==
            [1, 2, 3]
        )
        
        do {
            var array: [Int] = [1, 2, 3]
            array.reverse(false)
            
            #expect(array == [1, 2, 3])
        }
    }
    
    @Test
    func testReversedTrue() {
        #expect(
            [1, 2, 3].reversed(true) ==
            [3, 2, 1]
        )
        
        do {
            var array: [Int] = [1, 2, 3]
            array.reverse(true)
            
            #expect(array == [3, 2, 1])
        }
    }
}
