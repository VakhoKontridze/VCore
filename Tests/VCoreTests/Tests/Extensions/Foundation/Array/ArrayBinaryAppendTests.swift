//
//  ArrayBinaryAppendTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ArrayBinaryAppendTests {
    @Test
    func test() {
        let array: [Int] = [1, 2, 4, 5, 6]

        var appendedArray: [Int] = array
        let index: Int = appendedArray.binaryAppend(3, by: { $0 < $1 })

        #expect(appendedArray == [1, 2, 3, 4, 5, 6])
        #expect(index == 2)
    }
}
