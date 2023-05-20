//
//  ArrayBinaryAppendTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayBinaryAppendTests: XCTestCase {
    // MARK: Test Data
    private let input: [Int] = [1, 2, 4, 5, 6]

    private let output: [Int] = [1, 2, 3, 4, 5, 6]
    private let outputIndex: Int = 2

    // MARK: Tests
    func test() {
        var result: [Int] = input
        let resultIndex: Int = result.binaryAppend(3, by: { $0 < $1 })

        XCTAssertEqual(result, output)
        XCTAssertEqual(resultIndex, outputIndex)
    }
}
