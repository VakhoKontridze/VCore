//
//  ArrayAppendingTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.11.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayAppendingTests: XCTestCase {
    func testElement() {
        let array: [Int] = [1, 2]

        let appendedArray: [Int] = array.appending(3)

        XCTAssertEqual(appendedArray, [1, 2, 3])
    }

    func testElements() {
        let array: [Int] = [1, 2]

        let appendedArray: [Int] = array.appending(contentsOf: [3, 4])

        XCTAssertEqual(appendedArray, [1, 2, 3, 4])
    }
}
