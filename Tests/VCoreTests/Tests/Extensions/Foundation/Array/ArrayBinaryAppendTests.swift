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
    func test() {
        let array: [Int] = [1, 2, 4, 5, 6]

        var appendedArray: [Int] = array
        let index: Int = appendedArray.binaryAppend(3, by: { $0 < $1 })

        XCTAssertEqual(appendedArray, [1, 2, 3, 4, 5, 6])
        XCTAssertEqual(index, 2)
    }
}
