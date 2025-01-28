//
//  ArrayAsyncSortedTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ArrayAsyncSortedTests {
    @Test
    func testSorted() async {
        let array: [String] = ["London", "Paris", "New York"]

        let sortedArray: [String] = await array.asyncSorted(by: { (lhs, rhs) in
            try? await Task.sleep(nanoseconds: 1_000)
            return lhs < rhs
        })

        #expect(sortedArray == array.sorted())
    }

    @Test
    func testSorting() async {
        let array: [String] = ["London", "Paris", "New York"]

        var sortedArray: [String] = array
        await sortedArray.asyncSort(by: { (lhs, rhs) in
            try? await Task.sleep(nanoseconds: 1_000)
            return lhs < rhs
        })

        #expect(sortedArray == array.sorted())
    }
}
