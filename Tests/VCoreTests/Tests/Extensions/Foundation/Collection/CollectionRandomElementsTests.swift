//
//  CollectionRandomElementsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 30.04.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CollectionRandomElementsTests {
    @Test
    func testValid() throws {
        let numbers: [Int] = [1, 3, 5, 7, 9]

        try 10.times {
            let randomNumbers: [Int] = try #require(
                numbers.randomElements(Int.random(in: 0...numbers.count))
            )

            #expect(randomNumbers.isUnique)
            #expect(randomNumbers.count <= numbers.count)
        }
    }

    @Test
    func testOutOfBounds() {
        let numbers: [Int] = [1, 3, 5, 7, 9]

        #expect(numbers.randomElements(-1) == nil)
        #expect(numbers.randomElements(numbers.count+1) == nil)
    }
}
