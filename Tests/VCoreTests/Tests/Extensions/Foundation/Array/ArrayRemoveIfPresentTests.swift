//
//  ArrayRemoveIfPresentTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 26.11.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ArrayRemoveIfPresentTests {
    @Test
    func testRemoveElement() {
        let array: [Int] = [1, 2, 3]

        var filteredArray = array
        filteredArray.removeIfPresent(3)

        #expect(filteredArray == [1, 2])
    }

    @Test
    func testRemoveElements() {
        let array: [Int] = [1, 2, 3]

        var filteredArray = array
        filteredArray.removeIfPresent(contentsOf: [2, 3])

        #expect(filteredArray == [1])
    }
}
