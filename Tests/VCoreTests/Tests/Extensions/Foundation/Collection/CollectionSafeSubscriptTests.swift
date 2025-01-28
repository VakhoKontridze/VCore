//
//  CollectionSafeSubscriptTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CollectionSafeSubscriptTests {
    @Test
    func test() {
        let numbers: [Int] = [1, 3, 5]

        #expect(numbers[safe: -1] == nil)
        
        for i in numbers.indices {
            #expect(numbers[safe: i] == numbers[i])
        }
        
        #expect(numbers[safe: 3] == nil)
    }
}
