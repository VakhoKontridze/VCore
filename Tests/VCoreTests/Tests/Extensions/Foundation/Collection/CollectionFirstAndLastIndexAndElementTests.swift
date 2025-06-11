//
//  CollectionFirstAndLastIndexAndElementTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CollectionFirstAndLastIndexAndElementTests {
    @Test
    func testFirstIndexAndElement() {
        let numbers: [Int] = [1, 3, 5, 7]
        
        #expect(numbers.firstIndexAndElement { $0 == 0 } == nil)
        
        do {
            let result: (index: Int, element: Int)? = numbers.firstIndexAndElement { $0 * $0 >= 10 }
            
            #expect(result?.index == 2)
            #expect(result?.element == 5)
        }
    }
    
    @Test
    func testLastIndexAndElement() {
        let numbers: [Int] = [1, 3, 5, 7]
        
        #expect(numbers.lastIndexAndElement { $0 == 0 } == nil)
        
        do {
            let result: (index: Int, element: Int)? = numbers.lastIndexAndElement { $0 * $0 >= 10 }

            #expect(result?.index == 3)
            #expect(result?.element == 7)
        }
    }
}
