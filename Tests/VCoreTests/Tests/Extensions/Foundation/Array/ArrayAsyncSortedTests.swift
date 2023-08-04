//
//  ArrayAsyncSortedTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayAsyncSortedTests: XCTestCase {
    // MARK: Test Data
    private let input: [String] = ["London", "Paris", "New York"]
    private var output: [String] { input.sorted() }

    // MARK: Tests
    func testSorted() async {
        let result: [String] = await input.asyncSorted(by: { (lhs, rhs) in
            try? await Task.sleep(nanoseconds: 1_000)
            return lhs < rhs
        })

        XCTAssertEqual(result, output)
    }

    func testSorting() async {
        var result: [String] = input
        await result.asyncSort(by: { (lhs, rhs) in
            try? await Task.sleep(nanoseconds: 1_000)
            return lhs < rhs
        })

        XCTAssertEqual(result, output)
    }
}
