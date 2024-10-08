//
//  CollectionSafeSubscriptTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class CollectionSafeSubscriptTests: XCTestCase {
    func testLowerOutOfBoundsSubscript() {
        let numbers: [Int] = [1, 3, 5]

        XCTAssertNil(numbers[safe: -1])
    }

    func testValidSubscript() {
        let numbers: [Int] = [1, 3, 5]

        for i in numbers.indices {
            XCTAssertEqual(numbers[safe: i], numbers[i])
        }
    }

    func testUpperOutOfBoundsSubscript() {
        let numbers: [Int] = [1, 3, 5]

        XCTAssertNil(numbers[safe: 3])
    }
}
