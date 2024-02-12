//
//  ArrayAsyncSortedTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayAsyncSortedTests: XCTestCase {
    func testSorted() async {
        let array: [String] = ["London", "Paris", "New York"]

        let sortedArray: [String] = await array.asyncSorted(by: { (lhs, rhs) in
            try? await Task.sleep(nanoseconds: 1_000)
            return lhs < rhs
        })

        XCTAssertEqual(sortedArray, array.sorted())
    }

    func testSorting() async {
        let array: [String] = ["London", "Paris", "New York"]

        var sortedArray: [String] = array
        await sortedArray.asyncSort(by: { (lhs, rhs) in
            try? await Task.sleep(nanoseconds: 1_000)
            return lhs < rhs
        })

        XCTAssertEqual(sortedArray, array.sorted())
    }
}
